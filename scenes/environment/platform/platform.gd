@tool
extends AnimatableBody2D
class_name Platform

@export_enum("cake", "grass", "sand", "snow", "stone", "wood") var platform_environment: String = "grass":
	set(val):
		platform_environment = val
		_load_sprite_texture() if not Engine.is_editor_hint() else _load_sprite_texture_from_editor()
		_enable_collision_polygon()

@export var is_small_platform: bool = false:
	set(val):
		is_small_platform = val
		_load_sprite_texture() if not Engine.is_editor_hint() else _load_sprite_texture_from_editor()
		_enable_collision_polygon()
		
@export var is_broken_platform: bool = false:
	set(val):
		is_broken_platform = val
		_load_sprite_texture() if not Engine.is_editor_hint() else _load_sprite_texture_from_editor()
		_enable_collision_polygon()

@onready var sprite: Sprite2D = %Sprite2D
@onready var collision_polygon: CollisionPolygon2D = %CollisionPolygonPlatform
@onready var collision_polygon_small: CollisionPolygon2D = %CollisionPolygonPlatformSmall


func _ready() -> void:
	print("is ready executed?")
	_load_sprite_texture() if not Engine.is_editor_hint() else _load_sprite_texture_from_editor()
	_enable_collision_polygon()

func _load_sprite_texture() -> void:
	# the function loads the sprite depending on the initial configuration
	# of the platform environment, and is flags
	
	print("are we at least here?")
	
	if not sprite:
		return
		
	print("you should be here right?")
	
	var texture: Texture2D = PlatformTextures.get_platform_texture(platform_environment, is_small_platform, is_broken_platform)
	
	print("and now here")
	print(texture)
	sprite.set_texture(texture)

func _load_sprite_texture_from_editor() -> void:
	# the platform scene is marked as tool and allows updating itself from within
	# the editor but when running in the editor there is no access to the 
	# singleton so we need to manually load and switch

	if not sprite:
		return
	
	var sprite_file = "res://assets/gfx/environment/platforms/ground_%s" % platform_environment
	if is_small_platform:
		sprite_file += "_small"
	if is_broken_platform:
		sprite_file += "_broken"
	sprite_file += ".png"
	
	sprite.set_texture(load(sprite_file))

func _enable_collision_polygon() -> void:
	# enables the correct collision poliy
	
	if not collision_polygon or not collision_polygon_small:
		return
	
	if is_small_platform:
		
		collision_polygon_small.disabled = false
		collision_polygon_small.show()
		collision_polygon.disabled = true
		collision_polygon.hide()
	else:
		collision_polygon.disabled = false
		collision_polygon.show()
		collision_polygon_small.disabled = true
		collision_polygon_small.hide()
