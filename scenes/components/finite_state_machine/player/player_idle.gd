extends State
class_name PlayerIdle

# ========
# singleton references
# ========

# ========
# export vars
# ========

@export var player: Player

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

# ========
# signal handler
# ========

# ========
# class functions
# ========

func enter() -> void:
	# play idle animation 
	
	if not player.animated_sprite:
		return
		
	player.animated_sprite.play("idle")
	player.current_jump_count = 0

func physics_update(_delta: float) -> void:
	# check for possible physics based state changes
	
	# if the player falls, jumps or moves
	if not player:
		return
		
	if not player.is_on_floor():
		transition_to.emit(self, "PlayerFall")
	elif Input.is_action_just_pressed("jump"):
		transition_to.emit(self, "PlayerJump")
	elif Input.get_axis("move_left", "move_right") != 0:
		transition_to.emit(self, "PlayerWalk")
