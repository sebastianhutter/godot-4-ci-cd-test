extends Manager
class_name PlatformManager

# ========
# singleton references
# ========

# ========
# export vars
# ========

@export_enum("cake", "grass", "sand", "snow", "stone", "wood") var starting_environment: String = "grass"
@export var spawn_area_y_offset: int = 0: 
	set(val):
		spawn_area_y_offset = val
		_set_spawning_area()
@export var despawn_area_y_offset: int = 250:
	set(val):
		despawn_area_y_offset = val
		_set_despawning_area()
@export var seconds_between_platform_spawns: float = 2.0


# ========
# class signals
# ========

# ========
# class onready vars
# ========

@onready var platform_scene: PackedScene = load("res://scenes/environment/platform/platform.tscn")
@onready var platform_spawn_area: PlatformSpawnArea = %PlatformSpawnArea
@onready var platform_despawn_area: PlatformSpawnArea = %PlatformDeSpawnArea
@onready var platform_spawn_timer: Timer = %PlatformSpawnTimer

# ========
# class vars
# ========

var rng: RandomNumberGenerator = RandomNumberGenerator.new()

# ========
# godot functions
# ========

func _ready() -> void:
	super()
	
	get_tree().root.size_changed.connect(_on_viewport_size_changed)
	
	if platform_spawn_timer:
		platform_spawn_timer.timeout.connect(_on_platform_spawn_timer_timeout)
	
	if platform_despawn_area:
		platform_despawn_area.body_entered.connect(_on_platform_despawn_body_entered)
	
	_set_spawning_area()
	_set_despawning_area()

func _process(_delta: float) -> void:
	_set_spawning_area()
	_set_despawning_area()

# ========
# signal handler
# ========

func _on_viewport_size_changed() -> void:
	""" executed if the screen size changes, ensures spawn areas are correctly positioned """
	
	_set_spawning_area()
	_set_despawning_area()

func _on_platform_spawn_timer_timeout() -> void:
	""" spawn platforms when timer timesout """
	
	if not platform_spawn_area:
		return
	
	_spawn_platform()
	platform_spawn_timer.start(seconds_between_platform_spawns)

func _on_platform_despawn_body_entered(body: Node) -> void:
	""" despawn platforms once they touch the despawn area """

	if not body is Platform:
		return
		
	body.queue_free()

# ========
# class functions
# ========

func _spawn_platform() -> void:
	
	var platform: Platform = platform_scene.instantiate()
	platform.platform_environment = starting_environment
	
	platform.position = _get_random_platform_spawn_position()
	
	_get_spawn_group().add_child(platform)

func _get_random_platform_spawn_position() -> Vector2:
	""" returns a random spawn position """ 

	if not platform_spawn_area:
		return Vector2.ZERO

	return Vector2(
		rng.randi_range(0, platform_spawn_area.get_length()), 
		platform_spawn_area.position.y)

func _get_spawn_group() -> Node:
	""" return the group platforms node2d or self """
	
	var group: Node = get_tree().get_first_node_in_group("platforms")
	
	if not group:
		return self
		
	return group

func _transition_to_game_loop() -> void:
	""" start the timer """
	# TODO: use an event or so that the player has a second or two before the
	# platforms start falling?
	
	if not platform_spawn_timer:
		return 
	
	_spawn_platform()
	platform_spawn_timer.start(seconds_between_platform_spawns)

func _transition_to_game_loop_from_pause_menu() -> void:
	# virtual func to overwrite for each manager to allow unpausing the game
	pass

func _transition_to_menu() -> void:
	""" ensure no more platforms are spawned and existing platforms are destroyed """
	
	if not platform_spawn_timer:
		return
	
	platform_spawn_timer.stop()
	
	get_tree().call_group("platform", "queue_free")

func _transition_to_pause() -> void:
	# virtual func to override for pause menu, and win / loose menu
	pass

func _set_spawning_area() -> void:
	""" set the spawning area depending on screen size """
	
	if not platform_spawn_area:
		return
		
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var player_pos: Vector2 = Util.get_player_position()
	
	# set the collision shape to fill the screen
	platform_spawn_area.set_collision_shape_coordinates(
		Vector2(0, 0), Vector2(viewport_size.x, 0))
	
	# position the spawn area outside of the viewport relative to the players
	# poisiton
	platform_spawn_area.position = Vector2(0,
			player_pos.y-viewport_size.y+spawn_area_y_offset)
	

func _set_despawning_area() -> void:
	""" set the despawning area dependning on """
	
	if not platform_despawn_area:
		return
		
	var viewport_size: Vector2 = get_viewport().get_visible_rect().size
	var player_pos: Vector2 = Util.get_player_position()
	
	platform_despawn_area.set_collision_shape_coordinates(
		Vector2(0, 0), Vector2(viewport_size.x, 0))
	
	platform_despawn_area.position = Vector2(0, 
	player_pos.y+viewport_size.y+despawn_area_y_offset+player_pos.y)
