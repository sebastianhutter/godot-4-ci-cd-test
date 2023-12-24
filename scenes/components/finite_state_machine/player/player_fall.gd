extends State
class_name PlayerFall

@export var player: Player

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func enter() -> void:
	# play idle animation 
	
	if not player.animated_sprite:
		return
		
	player.animated_sprite.play("jump")


func physics_update(_delta: float) -> void:
	
	if not player:
		return	
	
	if player.is_on_floor():
		transition_to.emit(self, "PlayerIdle")
		return

	if Input.is_action_just_pressed("jump"):
		transition_to.emit(self, "PlayerJump")

	# allow movement during fall
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = direction * player.speed
	else:
		player.velocity.x = move_toward(player.velocity.x, 0, player.speed)

	player.velocity.y += gravity * _delta
