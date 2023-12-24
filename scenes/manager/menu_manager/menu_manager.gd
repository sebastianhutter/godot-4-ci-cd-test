extends Manager
class_name MenuManager

const MODULE = "MenuManager"

@onready var factory_menu: FactoryMenu = %FactoryMenu
@onready var main_menu: MainMenu = %MainMenu
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var options_menu: OptionsMenu = %OptionsMenu
@onready var win_menu: GameOverWinMenu = %WinMenu
@onready var loose_menu: GameOverLooseMenu = %LooseMenu

# stores the currently opened menu (if any)
var menu_stack: Array[Menu] = []

func _init():
	Logger.add_module(MODULE)

# Called when the node enters the scene tree for the first time.
func _ready():
	# connect all button signals, the menu manager can handle the transition between the menus
	if main_menu:
		main_menu.play_button_pressed.connect(_on_main_menu_play_button_pressed)
		main_menu.options_button_pressed.connect(_on_any_options_button_pressed)
		main_menu.quit_button_pressed.connect(_on_main_menu_quit_button_pressed)

	if options_menu:
		options_menu.back_button_pressed.connect(_on_any_back_button_pressed)
	
	if pause_menu:
		pause_menu.continue_button_pressed.connect(_on_pause_menu_continue_button_pressed)
		pause_menu.options_button_pressed.connect(_on_any_options_button_pressed)
		pause_menu.quit_to_menu_button_pressed.connect(_on_pause_menu_quit_to_menu_button_pressed)


	
	# in game menues are requested from the scenes in the world scene, so need to work via the 
	# event bus
	EventBus.factory_menu_requested.connect(_on_factory_menu_requested)

func show_menu(menu: int, hide_last_menu: bool = true) -> void:
	"""show the given menu"""

	# use the enum to define the menu to load 
	# so the game state manager is able to run show_menu too!
	var new_menu = _resolve_menu_enum(menu)
	if new_menu == null:
		Logger.warn("New menu is null", MODULE)
		return

	if menu_stack.size() > 0:
		var current_menu: Menu = menu_stack[-1]
		if current_menu != null and hide_last_menu:
			current_menu.hide_menu()

	menu_stack.append(new_menu.show_menu())

func handle_escape_key() -> void:
	"""handle escape key pressed"""

	# if in main menu, send quit signal
	# if in pause menu, send continue signal
	# if in win or loose menu, clear stack and open main menu
	# if in options menu go back to last menu
	# if no menus or menu not found pause game
		
	var current_menu: Menu = menu_stack.back()
	
	match current_menu:
		main_menu:
			_quit_game()
		pause_menu:
			_unpause_game()
		options_menu:
			_show_last_menu()
		# if either null or unknown menu we send pause!
		_: 
			_pause_game()

func _resolve_menu_enum(menu: int) -> Menu:
	"""resolves the enum to a menu or null"""

	match menu:
		MENUS.MAIN:
			return main_menu
		MENUS.OPTIONS:
			return options_menu
		MENUS.PAUSE:
			return pause_menu
		MENUS.WIN:
			return win_menu
		MENUS.LOOSE:
			return loose_menu
		MENUS.FACTORY:
			return factory_menu
		_:
			Logger.error("Menu not found", MODULE)
			
	return null

func _show_last_menu() -> void:
	if menu_stack.size() > 1:
		var current_menu: Menu = menu_stack.pop_back()
		var new_menu: Menu = menu_stack.pop_back()
		
		current_menu.hide_menu()
		menu_stack.append(new_menu.show_menu())


func _on_factory_menu_requested(action: int) -> void:
	 # open or close the factory menu, the menu is an ingame menu so the state remains in game loop

	Logger.info("Factory Menu request received", MODULE)

	match action:
		MENU_ACTIONS.OPEN:
			_show_factory_menu()
		MENU_ACTIONS.CLOSE:
			_hide_factory_menu()
		MENU_ACTIONS.TOGGLE:
			# if menu_stack.back() == factory_menu:
			if menu_stack.has( factory_menu ): 
				_hide_factory_menu()
			else:
				_show_factory_menu()


func _on_any_back_button_pressed() -> void:
	"""called when the back button is pressed in any menu"""

	# go to the last menu in stack
	_show_last_menu()

func _on_any_options_button_pressed() -> void:
	"""called when the options button is pressed in any menu"""

	# set the game state to playing
	show_menu(MENUS.OPTIONS)
	

func _on_main_menu_play_button_pressed() -> void:
	"""called when the play button is pressed on the main menu"""

	EventBus.play_game_requested.emit()

func _on_main_menu_quit_button_pressed() -> void:
	"""called when the quit button is pressed on the main menu"""

	EventBus.quit_game_requested.emit()

func _on_pause_menu_quit_to_menu_button_pressed() -> void:
	"""called when the quit button is pressed on the pause menu"""

	EventBus.return_to_main_menu_requested.emit()

func _on_pause_menu_continue_button_pressed() -> void:
	""" called when continue is pressed on the pause menu """
	_unpause_game()
	
	
func _transition_to_menu() -> void:
	_hide_menus()
	show_menu(MENUS.MAIN)

func _transition_to_game_loop() -> void:
	# we could hide all menus here, but we have in game menus so lets manage the
	# hidding of the menus for each event separately
	
	# we assume that the top menu in the stack is either the main menu or the
	# pause menu, while menus further down can be in game menus which have
	# no influence on the game state

	_hide_menus()
	
func _transition_to_pause() -> void:
	show_menu(MENUS.PAUSE, false)
	
func _hide_menus() -> void:
	"""hide all game menus"""
	for child in get_children():
		child.visible = false

	menu_stack.clear()

func _unpause_game() -> void:
	if menu_stack.size() <= 0:
		Logger.warn("No menus even though in pause?", MODULE)
		return
		
	if menu_stack.back() != pause_menu:
		Logger.warn("Pause menu is not in front.", MODULE)
		return
		
	pause_menu.hide_menu()
	menu_stack.pop_back()
	EventBus.play_game_requested.emit()

func _pause_game() -> void:
	EventBus.pause_game_requested.emit()
	
func _quit_game() -> void:
	EventBus.quit_game_requested.emit()

func _show_factory_menu() -> void:
	show_menu(MENUS.FACTORY)
	
func _hide_factory_menu() -> void:
	
	factory_menu.hide_menu()
	# we assume the top menu in sthe stack is the factory menu and drop it
	menu_stack.pop_back()
