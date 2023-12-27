extends Manager
class_name LevelManager

# ========
# singleton references
# ========

# ========
# export vars
# ========

# ========
# class signals
# ========

# TODO: maybe go back to global event bus instead
# of passing the signal from water -> level -> level manager -> round manager?
signal player_hit_water

signal level_spawned

# ========
# class onready vars
# ========

@onready var level_scene: PackedScene = load("res://scenes/level/level.tscn")

# ========
# class vars
# ========

var level_instance: Level

# ========
# godot functions
# ========

func _ready():
	super()

# ========
# signal handler
# ========

func _on_player_hit_water() -> void:
	""" the player has hit water, the round ends here ! """
	
	game_over_requested.emit()

# ========
# class functions
# ========

func get_player_height() -> float:
	""" returns the height (y) of the player """
	
	var player_pos: Vector2 = Util.get_player_position()
	return player_pos.y

func _transition_to_game_loop() -> void:
	""" spawn in the level """
	
	# TODO: use an event or so that the player has a second or two before the
	# platforms start falling?
	
	if not level_scene:
		return 
		
	level_instance = level_scene.instantiate() as Level
	
	get_parent().add_child(level_instance)
	level_instance.player_hit_water.connect(_on_player_hit_water)
	level_instance.raise_water()
	level_spawned.emit()

func _transition_to_game_loop_from_pause_menu() -> void:
	# virtual func to overwrite for each manager to allow unpausing the game
	pass

func _transition_to_menu() -> void:
	""" remove all level resourcves """
	
	if not level_instance:
		return
	
	level_instance.queue_free()
