extends CharacterBody2D
class_name Player

# thanks to https://www.youtube.com/watch?v=hYbG0wlidsY

# ========
# singleton references
# ========

# ========
# export vars
# ========

@export var speed: float = 400.0
@export var jump_power: float = -2000.0
@export var acceleration: float = 50.0
@export var friction: float = 70.0
@export var allowed_jumps: int = 3
@export var gravity: float = 120.0
# ========
# class signals
# ========

# ========
# class onready vars
# ========

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D

# ========
# class vars
# ========

var current_jump_count = 0

# ========
# godot functions
# ========

func _physics_process(_delta: float) -> void:
	_move()
	_jump()
	_animate()
	move_and_slide()

# ========
# signal handler
# ========

# ========
# class functions
# ========

func _move() -> void:
	""" handles the player movement """
	
	var direction: Vector2 = _get_movement_direction()
	if direction != Vector2.ZERO:
		_accelerate(direction)
	else:
		_add_friction()

func _jump() -> void: 
	""" let the player jump n times """
	
	if Input.is_action_just_pressed("jump"):
		if current_jump_count <= allowed_jumps:
			velocity.y = jump_power
			current_jump_count += 1
	else:
		if not is_on_floor():
			velocity.y += gravity
		
	if is_on_floor():
		current_jump_count = 0

func _animate() -> void:
	""" animates the player sprite """
	
	if Input.is_action_just_pressed("jump"):
		animated_sprite.play("jump")
		return
		
	if not is_on_floor():
		animated_sprite.play("jump")
		return
	
	if velocity.x != 0:
		animated_sprite.play("walk")
	else:
		animated_sprite.play("idle")
	

func _accelerate(direction: Vector2) -> void:
	""" accelerates the player """
	velocity = velocity.move_toward(speed * direction, acceleration)
	
func _add_friction() -> void:
	""" add friction to the player char """
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func _get_movement_direction() -> Vector2:
	""" returns the normalized movement direction for the player """
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction < 0:
		animated_sprite.flip_h = true
	else:
		animated_sprite.flip_h = false
		
	return Vector2(direction, 0).normalized()
	
