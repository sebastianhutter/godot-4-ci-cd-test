extends Manager
class_name UiManager

# ========
# singleton references
# ========

# ========
# export vars
# ========

@export var level_manager: LevelManager

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
	super()
	
	if level_manager:
		level_manager.level_spawned.connect(_on_level_manager_level_spawned)
	
	_hide_all_ui_elements() 

# ========
# signal handler
# ========

func _on_level_manager_level_spawned() -> void:
	for child in get_children():
		# TODO: global event bus on the ui scene itself or use named
		# references to the ui children instead
		if child.has_method("start_height_counter"):
			child.start_height_counter()

# ========
# class functions
# ========

func _transition_to_game_loop() -> void:
	for child in get_children():
		if child.has_method("reset"):
			child.reset()
	_show_all_ui_elements() 
	
func _transition_to_menu() -> void:
	_hide_all_ui_elements() 

func _transition_to_pause() -> void:
	_hide_all_ui_elements() 

func _transition_to_game_over() -> void:
	_hide_all_ui_elements() 
	
	
func _transition_to_game_loop_from_pause_menu() -> void:
	_show_all_ui_elements()

func _hide_all_ui_elements() -> void:
	for child in get_children():
		child.hide()
		
func _show_all_ui_elements() -> void:
	for child in get_children():
		child.show()

func get_height_from_ui() -> int:
	""" gets the height from the ui menu """
	
	# the height should be stored in a manager or singleton and not just the ui
	# but good enough for the mini game loop (goal is to test build 
	# pipelines and not to write a game after all)
	
	for child in get_children():
		if child.has_method("get_height"):
			return child.get_height()

	return 0
