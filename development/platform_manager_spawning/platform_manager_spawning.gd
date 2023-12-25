extends Node2D

@onready var platform_manager: PlatformManager = %PlatformManager

func _ready():
	platform_manager._transition_to_game_loop()
