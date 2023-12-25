extends Area2D
class_name PlatformSpawnArea

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

@onready var collision_shape: CollisionShape2D = %CollisionShape2D

# ========
# class vars
# ========

# ========
# godot functions
# ========

# ========
# signal handler
# ========

# ========
# class functions
# ========

func get_length() -> int:
	""" returns the x coordinate of the collision shape"""
	
	if not collision_shape:
		return -1
		
	return collision_shape.shape.b.x

func set_collision_shape_coordinates(a: Vector2, b: Vector2) -> void:
	""" sets the coordinates for the collision shape """
	if not collision_shape:
		return
	
	collision_shape.shape.a = a
	collision_shape.shape.b = b


