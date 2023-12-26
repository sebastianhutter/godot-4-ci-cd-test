extends Node
class_name UtilSingleton

func get_player_position() -> Vector2:
	""" gets the current player position, used to ensure spawning areas are always
	out of view """

	var player: Player = get_tree().get_first_node_in_group("player")
	if not player:
		return Vector2.ZERO
	
	return player.position
