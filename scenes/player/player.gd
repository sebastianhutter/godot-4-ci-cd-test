extends CharacterBody2D
class_name Player


# ========
# singleton references
# ========

# ========
# export vars
# ========

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var allowed_jumps: int = 3

# ========
# class signals
# ========

# ========
# class onready vars
# ========

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var fsm: FiniteStateMachine = %FiniteStateMachine

# ========
# class vars
# ========

var current_jump_count = 0

# ========
# godot functions
# ========


func _physics_process(_delta: float) -> void:
	move_and_slide()


# ========
# signal handler
# ========

# ========
# class functions
# ========
