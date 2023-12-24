extends Node
class_name FiniteStateMachine

# thanks to https://www.youtube.com/watch?v=ow_Lum-Agbs
@export var initial_state: State
var available_states: Dictionary = {}
var active_state: State = null

# Called when the node enters the scene tree for the first time.
func _ready():
	_load_available_states()
	_set_initial_state()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if active_state:
		active_state.update(delta)

func _physics_process(delta):
	if active_state:
		active_state.physics_update(delta)

func _load_available_states() -> void:
	# adds all available states to the dict for processing
	
	for child in get_children():
		if not child is State:
			continue
		available_states[child.name.to_lower()] = child
		child.transition_to.connect(_on_state_transition_to)

func _set_initial_state() -> void:
	# enters the defined initial state
	
	if not initial_state:
		return
		
	if owner:
		await owner.ready
		
	initial_state.enter()
	active_state = initial_state

func set_state(new_state_name: String) -> void:
	# allow setting state from parent
	
	_on_state_transition_to(active_state, new_state_name)

func _on_state_transition_to(current_state: State, new_state_name: String) -> void:
	# called on state transitions

	var next_state = available_states.get(new_state_name.to_lower())
	if not next_state:
		return
	
	if active_state == next_state:
		return
	
	if active_state != null:
		active_state.exit()
	
	next_state.enter()
	active_state = next_state
