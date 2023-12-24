extends State
class_name PlayerJump

@export var player: Player

func enter() -> void:
	
	if not player.animated_sprite:
		return
	
	if not player.is_on_floor() and player.current_jump_count >= player.allowed_jumps:
		transition_to.emit(self, "PlayerFall")
		return
	
	player.animated_sprite.play("jump")
	player.velocity.y = player.jump_velocity
	player.current_jump_count += 1


func physics_update(_delta: float) -> void:
	
	if not player:
		return
	
	if not player.is_on_floor():
		transition_to.emit(self, "PlayerFall")
	
