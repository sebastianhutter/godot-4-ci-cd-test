extends Node
class_name Manager

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

# ========
# godot functions
# ========

func _ready() -> void:
	add_to_group("managers")
	_initialize_manager()

# ========
# signal handler
# ========

# ========
# class functions
# ========

func transition_to_game_loop(is_initial_game_loop: bool) -> void:
	if is_initial_game_loop:
		_transition_to_game_loop()
	else:
		_transition_to_game_loop_from_pause_menu()

func transition_to_menu() -> void:
	_transition_to_menu()
	
func transition_to_pause() -> void:
	_transition_to_pause()

func handle_escape_key() -> void:
	print('mabager key')
	_handle_escape_key()

func _transition_to_game_loop() -> void:
	# virtual func to overwrite for each manager to allow initialization when game starts
	pass

func _transition_to_game_loop_from_pause_menu() -> void:
	# virtual func to overwrite for each manager to allow unpausing the game
	pass

func _transition_to_menu() -> void:
	# virtual func to allow actions when main menu is reached
	pass

func _transition_to_pause() -> void:
	# virtual func to override for pause menu, and win / loose menu
	pass

func _handle_escape_key() -> void:
	# virtual func to override, is executed on all managers if the escape key is
	# pressed
	pass

func _initialize_manager() -> void:
	# use this one in the base manager class instead of the godot _ready
	# function
	pass
