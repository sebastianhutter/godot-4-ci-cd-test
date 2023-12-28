extends Camera2D

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

func _ready():
	_center_camera()

func _physics_process(_delta):
	_follow_player_on_y_axis()

# ========
# signal handler
# ========

# ========
# class functions
# ========

func _center_camera() -> void:
	""" centers the camera in the center of the screen """
	
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	position.x = viewport_size.x / 2
	position.y = viewport_size.y / 2

func _follow_player_on_y_axis() -> void:
	""" follows the player on the y axis """
	
	var player_pos: Vector2 = Util.get_player_position()
	position.y = player_pos.y
