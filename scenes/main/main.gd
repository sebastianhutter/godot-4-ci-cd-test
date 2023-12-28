extends Node2D
class_name Main

# ========
# singleton references
# ========

# ========
# export vars
# ========

# duplicated values from "library/game_state_enum.gd"
@export_enum("MENU", "GAME_LOOP", "PAUSE") var default_game_state: int = 0

# ========
# class signals
# ========

# ========
# class onready vars
# ========

@onready var game_manager: GameManager = %GameManager

# ========
# class vars
# ========

# ========
# godot functions
# ========

func _ready() -> void:
	if not game_manager:
		return
		
	game_manager.initiate_game(default_game_state)

# ========
# signal handler
# ========

# ========
# class functions
# ========
