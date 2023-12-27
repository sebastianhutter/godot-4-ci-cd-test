extends Control
class_name HeightCounter

# ========
# singleton references
# ========

# ========
# export vars
# ========

@export var height_to_meters: float = 100.0

# ========
# class signals
# ========

# ========
# class onready vars
# ========

@onready var height_label: Label = %Height

# ========
# class vars
# ========

var is_counting: bool = false
var starting_height: float  = 0.0
var max_height: float = 0.0:
	set(val):
		max_height = val
		_update_height_Label()

# ========
# godot functions
# ========

func _ready():
	pass

func _process(_delta):
	pass

func _physics_process(_delta):
	""" get the player position and """
	
	if not is_counting:
		return
		
	var player_pos_relative: float = abs(Util.get_player_position().y - starting_height)		
	if player_pos_relative < max_height:
		return
	
	max_height = player_pos_relative

# ========
# signal handler
# ========

# ========
# class functions
# ========

func reset() -> void:
	""" called by ui manager when game loop is entered """

	is_counting = false
	starting_height = 0.0
	max_height = 0.0

func start_height_counter() -> void:
	
	# ugly hack to ensure the player is properly positioned
	# this is way the height counter should be in fact part of the player
	# or a general manager knowing of the level, the current game state etc
	await get_tree().create_timer(0.25).timeout
	
	var player_pos = Util.get_player_position()
	starting_height = player_pos.y
	
	is_counting = true
	
func _update_height_Label() -> void:
	if not height_label:
		return
	
	var calculated_meters: float = 0.0
	
	if abs(max_height) > 0.0:
		calculated_meters = abs(max_height)/height_to_meters

	height_label.text = "Height Reached: %03dm" % calculated_meters
