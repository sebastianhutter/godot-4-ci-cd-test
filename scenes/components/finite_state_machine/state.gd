extends Node
class_name State

signal transition_to(active_state: State, new_state_name: String)

func enter() -> void:
	# executed when state is enetered
	
	pass

func exit() -> void: 
	# executed when state is left

	pass
	

func update(_delta: float) -> void:
	# called during process tick
	
	pass
	
func physics_update(_delta: float) -> void:
	# called during physics process tick
	
	pass
	
