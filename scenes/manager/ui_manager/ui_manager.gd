extends Manager
class_name UiManager

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
	super()
	
	_hide_all_ui_elements() 

# ========
# signal handler
# ========

# ========
# class functions
# ========

func _transition_to_game_loop() -> void:
	_show_all_ui_elements() 
	
func _transition_to_menu() -> void:
	_hide_all_ui_elements() 

func _transition_to_pause() -> void:
	_hide_all_ui_elements() 
	
func _transition_to_game_loop_from_pause_menu() -> void:
	_show_all_ui_elements()

func _hide_all_ui_elements() -> void:
	for child in get_children():
		child.hide()
		
func _show_all_ui_elements() -> void:
	for child in get_children():
		child.show()


