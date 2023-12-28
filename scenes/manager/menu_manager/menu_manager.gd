extends Manager
class_name MenuManager


# ========
# singleton references
# ========

# ========
# export vars
# ========

@export var ui_manager: UiManager

# ========
# class signals
# ========

# ========
# class onready vars
# ========

@onready var main_menu: MainMenu = %MainMenu
@onready var pause_menu: PauseMenu = %PauseMenu
@onready var options_menu: OptionsMenu = %OptionsMenu
@onready var game_over_menu: GameOverMenu = %GameOverMenu

# ========
# class vars
# ========

# stores the currently opened menu (if any)
var menu_stack: Array[Menu] = []

# ========
# godot functions
# ========

func _ready() -> void:
	super()
	
	if main_menu:
		main_menu.play_button_pressed.connect(_on_main_menu_play_button_pressed)
		main_menu.options_button_pressed.connect(_on_any_options_button_pressed)
		main_menu.quit_button_pressed.connect(_on_main_menu_quit_button_pressed)

	if options_menu:
		options_menu.back_button_pressed.connect(_on_any_back_button_pressed)
	
	if pause_menu:
		pause_menu.continue_button_pressed.connect(_on_pause_menu_continue_button_pressed)
		pause_menu.options_button_pressed.connect(_on_any_options_button_pressed)
		pause_menu.quit_to_menu_button_pressed.connect(_on_any_to_menu_button_pressed)
		pause_menu.restart_button_pressed.connect(_on_any_restart_button_pressed)

	if game_over_menu:
		game_over_menu.quit_to_menu_button_pressed.connect(_on_any_to_menu_button_pressed)
		game_over_menu.restart_button_pressed.connect(_on_any_restart_button_pressed)

	_hide_menus()

# ========
# signal handler
# ========

# ========
# class functions
# ========

func show_menu(menu: int, hide_last_menu: bool = true, payload: Dictionary = {}) -> void:
	"""show the given menu"""

	# use the enum to define the menu to load 
	# so the game state manager is able to run show_menu too!
	var new_menu = _resolve_menu_enum(menu)
	if new_menu == null:
		return

	if menu_stack.size() > 0:
		var current_menu: Menu = menu_stack[-1]
		if current_menu != null and hide_last_menu:
			current_menu.hide_menu()

	menu_stack.append(new_menu.show_menu(payload))

func _handle_escape_key() -> void:
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
		game_over_menu:
			pass
		# if either null or unknown menu we send pause!
		_: 
			_pause_game()

func _resolve_menu_enum(menu: int) -> Menu:
	"""resolves the enum to a menu or null"""

	match menu:
		MENU.MAIN:
			return main_menu
		MENU.OPTIONS:
			return options_menu
		MENU.PAUSE:
			return pause_menu
		MENU.GAME_OVER:
			return game_over_menu

	return null

func _show_last_menu() -> void:
	if menu_stack.size() > 1:
		var current_menu: Menu = menu_stack.pop_back()
		var new_menu: Menu = menu_stack.pop_back()
		
		current_menu.hide_menu()
		menu_stack.append(new_menu.show_menu())

func _on_any_back_button_pressed() -> void:
	"""called when the back button is pressed in any menu"""

	# go to the last menu in stack
	_show_last_menu()

func _on_any_options_button_pressed() -> void:
	"""called when the options button is pressed in any menu"""

	# set the game state to playing
	show_menu(MENU.OPTIONS)
	

func _on_main_menu_play_button_pressed() -> void:
	"""called when the play button is pressed on the main menu"""

	play_game_requested.emit()

func _on_main_menu_quit_button_pressed() -> void:
	"""called when the quit button is pressed on the main menu"""

	quit_game_requested.emit()

func _on_pause_menu_continue_button_pressed() -> void:
	""" called when continue is pressed on the pause menu """
	_unpause_game()

func _on_any_to_menu_button_pressed() -> void:
	"""called when the quit button is pressed in any game menu """

	return_to_main_menu_requested.emit()

func _on_any_restart_button_pressed() -> void:
	""" called when the restart button is pressed in any game menu """
	
	restart_game_requested.emit()
	
func _transition_to_menu() -> void:
	_hide_menus()
	show_menu(MENU.MAIN)

func _transition_to_game_loop() -> void:
	# we could hide all menus here, but we have in game menus so lets manage the
	# hidding of the menus for each event separately
	
	# we assume that the top menu in the stack is either the main menu or the
	# pause menu, while menus further down can be in game menus which have
	# no influence on the game state
	_hide_menus()
	
func _transition_to_pause() -> void:
	show_menu(MENU.PAUSE, false)

func _transition_to_game_over() -> void:
	
	var height: int = 0
	if ui_manager:
		height = ui_manager.get_height_from_ui()
	
	show_menu(MENU.GAME_OVER, true, {meters = height})

func _hide_menus() -> void:
	"""hide all game menus"""
	for child in get_children():
		if not child is Menu:
			continue
		
		child.visible = false

	menu_stack.clear()

func _unpause_game() -> void:
	if menu_stack.size() <= 0:
		return
		
	if menu_stack.back() != pause_menu:
		return
		
	pause_menu.hide_menu()
	menu_stack.pop_back()
	play_game_requested.emit()

func _pause_game() -> void:
	pause_game_requested.emit()
	
func _quit_game() -> void:
	quit_game_requested.emit()
