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
			GAME_STATE.GAME_OVER:
				_transition_managers_to_game_over()
				get_tree().paused = true
			
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
		
		child.quit_game_requested.connect(_on_quit_game_requested)
		child.play_game_requested.connect(_on_play_game_requested)
		child.pause_game_requested.connect(_on_pause_game_requested)
		child.restart_game_requested.connect(_on_restart_game_requested)
		child.return_to_main_menu_requested.connect(_on_return_to_main_menu_requested)
		child.game_over_requested.connect(_on_game_over_requested)

func _unhandled_input(event) -> void:
	""" handle escape key presses """

	if event is InputEventKey:
		# handle escape key presses
		if event.pressed and event.keycode == KEY_ESCAPE:
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

func _on_restart_game_requested() -> void:
	
	# we fake a restart by transitioning to main menu
	# which removes all spawned resources
	# and then immediately back to the game loop which recreates everything
	
	for manager in managers:
		manager.transition_to_menu()
	
	for manager in managers:
		manager.transition_to_game_loop(true)
		
	get_tree().paused = false
	
	
func _on_game_over_requested() -> void:
	print("signal arrived in game manager")
	current_game_state = GAME_STATE.GAME_OVER

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

func _transition_managers_to_game_over() -> void:
	print("transitioning managers to game over")
	for manager in managers:
		print(manager.name)
		manager.transition_to_game_over()

func _reset_managers() -> void:
	for manager in managers:
		manager.reset()

