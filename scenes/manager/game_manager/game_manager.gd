extends Node
class_name GameManager

# ========
# singleton references
# ========

# ========
# export vars
# ========

# ========
# class signals
# ========

# ========
# class onready vars
# ========

# ========
# class vars
# ========

var managers: Array[Manager] = []

var current_game_state: int: 
	set(val):
		match val:
			GAME_STATE.MENU:
				_transition_managers_to_menu()
				get_tree().paused = true
			GAME_STATE.PAUSE:
				_transition_managers_to_pause()
				get_tree().paused = true
			GAME_STATE.GAME_LOOP:
				_transition_managers_to_game_loop()
				get_tree().paused = false
			
		current_game_state = val

# ========
# godot functions
# ========

func _ready() -> void:
	# connect game signals
	
	for child in get_children():
		if not child is Manager:
			continue

		managers.append(child)

	EventBus.quit_game_requested.connect(_on_quit_game_requested)
	EventBus.play_game_requested.connect(_on_play_game_requested)
	EventBus.pause_game_requested.connect(_on_pause_game_requested)
	EventBus.return_to_main_menu_requested.connect(_on_return_to_main_menu_requested)

func _unhandled_input(event) -> void:
	""" handle escape key presses """

	if event is InputEventKey:
		# handle escape key presses
		if event.pressed and event.keycode == KEY_ESCAPE:
			print('que')
			get_tree().call_group("managers", "handle_escape_key")
		
# ========
# signal handler
# ========

func _on_quit_game_requested() -> void:
	# quit the game 
	_quit_game()

func _on_play_game_requested() -> void:
	
	if current_game_state == GAME_STATE.GAME_LOOP:
		return
	
	current_game_state = GAME_STATE.GAME_LOOP

func _on_pause_game_requested() -> void:
	current_game_state = GAME_STATE.PAUSE

func _on_return_to_main_menu_requested() -> void:
	if current_game_state == GAME_STATE.MENU:
		return
		
	current_game_state = GAME_STATE.MENU

# ========
# class functions
# ========

func initiate_game(initial_game_state: int) -> void:
	# called by the main scene in ready
	

	current_game_state = initial_game_state

func _quit_game() -> void:
	get_tree().quit()

func _transition_managers_to_game_loop() -> void:
	
	var is_initial_game_loop = true
	if current_game_state == GAME_STATE.PAUSE:
		is_initial_game_loop = false
	
	for manager in managers:
		manager.transition_to_game_loop(is_initial_game_loop)
		
func _transition_managers_to_menu() -> void:
	for manager in managers:
		manager.transition_to_menu()
	
func _transition_managers_to_pause() -> void:
	for manager in managers:
		manager.transition_to_pause()
		
func _reset_managers() -> void:
	for manager in managers:
		manager.reset()

