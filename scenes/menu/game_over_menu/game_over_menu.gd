extends Menu
class_name GameOverMenu

# ========
# singleton references
# ========

# ========
# export vars
# ========

# ========
# class signals
# ========


signal restart_button_pressed
signal quit_to_menu_button_pressed

# ========
# class onready vars
# ========

@onready var label: Label = %Label
@onready var restart_button: SoundButton = %RestartButton
@onready var quit_to_menu_button: SoundButton = %QuitToMenuButton

# ========
# class vars
# ========

# ========
# godot functions
# ========

func _ready() -> void:
	restart_button.pressed.connect(_on_restart_button_pressed)
	quit_to_menu_button.pressed.connect(_on_quit_to_menu_button_pressed)


# ========
# signal handler
# ========

func _on_restart_button_pressed() -> void:
	restart_button_pressed.emit()

func _on_quit_to_menu_button_pressed() -> void:
	quit_to_menu_button_pressed.emit()

# ========
# class functions
# ========

func _on_show(payload: Dictionary) -> void:
	""" sets the game over text with the meters received from the ui """
	
	if not payload.has("meters"):
		return
	
	_set_game_over_text(payload.meters)

func _set_game_over_text(meters: int) -> void:
	""" sets the game over text with the reached height """
	
	if not label:
		return
		
	label.text = "Game Over\n\nYou have climbed %03d meters!" % meters
