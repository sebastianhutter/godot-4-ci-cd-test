extends Area2D
class_name Water

# ========
# singleton references
# ========

# ========
# export vars
# ========

@export var is_raising: bool = false:
	set(val):
		is_raising = val
		set_physics_process(is_raising)

@export var raise_speed: float = 25.0

# ========
# class signals
# ========

signal hit_water

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
	set_physics_process(is_raising)
	body_entered.connect(_on_body_entered)

func _physics_process(_delta: float) -> void:
	position.y -= raise_speed * _delta

# ========
# signal handler
# ========

# ========
# class functions
# ========

func _on_body_entered(body: Node) -> void:
	if not body is Player:
		return
		
	hit_water.emit()
