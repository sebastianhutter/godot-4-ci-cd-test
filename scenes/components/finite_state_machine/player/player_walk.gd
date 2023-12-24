extends State
class_name PlayerWalk

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
	# play walk animation 
	
	if not player.animated_sprite:
		return
		
	player.animated_sprite.play("walk")
	
func physics_update(delta):
	
	if not player:
		return
		
	var direction = Input.get_axis("move_left", "move_right")
	
	if direction < 0:
		player.animated_sprite.flip_h = true
	else:
		player.animated_sprite.flip_h = false
	
	if direction:
		player.velocity.x = direction * player.speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)

	if player.velocity.x == 0:
		transition_to.emit(self, "PlayerIdle")
	
	if Input.is_action_just_pressed("jump"):
		transition_to.emit(self, "PlayerJump")
	
