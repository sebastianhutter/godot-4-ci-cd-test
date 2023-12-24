extends CharacterBody2D
class_name Player

@export var speed: float = 300.0
@export var jump_velocity: float = -400.0
@export var allowed_jumps: int = 3

@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D
@onready var fsm: FiniteStateMachine = %FiniteStateMachine

var current_jump_count = 0

func _physics_process(delta):
	move_and_slide()

