extends Camera2D

# ========
# singleton references
# ========

# ========
# export vars
# ========

@export var camera_speed: float = 10.0

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

func _ready():
	pass

func _process(_delta):
	pass

func _physics_process(_delta):
	
	var direction_x = Input.get_axis("move_left", "move_right")
	var direction_y = Input.get_axis("jump", "down")
	
	var movement_direction = Vector2(direction_x, direction_y).normalized()
	position += movement_direction * camera_speed
# ========
# signal handler
# ========

# ========
# class functions
# ========

