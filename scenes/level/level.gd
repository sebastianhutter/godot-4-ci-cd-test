extends Node2D
class_name Level

# ========
# singleton references
# ========

# ========
# export vars
# ========

# ========
# class signals
# ========

signal player_hit_water()

# ========
# class onready vars
# ========

@onready var water: Water = %Water
@onready var invisible_wall_left: InvisibleWall = %InvisibleWallLeft
@onready var invisible_wall_right: InvisibleWall = %InvisibleWallRight

# ========
# class vars
# ========

# ========
# godot functions
# ========

func _ready() -> void:
	if water:
		water.hit_water.connect(_on_hit_water)

func _process(_delta: float) -> void:
	_position_walls()

# ========
# signal handler
# ========

func _on_hit_water() -> void:
	player_hit_water.emit()

# ========
# class functions
# ========

func _position_walls() -> void:
	""" positions the walls so the player can't escape to the left or right """

	if not invisible_wall_left or not invisible_wall_right:
		return
		
	var player_pos: Vector2 = Util.get_player_position()
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
		
	invisible_wall_left.position.y = player_pos.y - viewport_size.y/2
	invisible_wall_right.position.y = player_pos.y - viewport_size.y/2

func raise_water() -> void:
	""" enables the raising water """
	
	if not water:
		return
		
	water.is_raising = true
