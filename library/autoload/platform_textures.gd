extends Node
class_name PlatformTexturesSingleton

const platform_sprites_folder: String = "res://assets/gfx/environment/platforms/" 

#var platform_textures_cake: Dictionary = {
	#"platform" = load(platform_sprites_folder + "ground_cake.png"),
	#"platform_broken" = load(platform_sprites_folder + "ground_cake_broken.png"),
	#"platform_small" = load(platform_sprites_folder + "ground_cake_small.png"),
	#"platform_small_broken" = load(platform_sprites_folder + "ground_cake_small_broken.png"),
#}

var platform_textures_grass: Dictionary = {
	"platform" = load(platform_sprites_folder + "ground_grass.png"),
	"platform_broken" = load(platform_sprites_folder + "ground_grass_broken.png"),
	"platform_small" = load(platform_sprites_folder + "ground_grass_small.png"),
	"platform_small_broken" = load(platform_sprites_folder + "ground_grass_small_broken.png"),
}
#
#var platform_textures_sand: Dictionary = {
	#"platform" = load(platform_sprites_folder + "ground_sand.png"),
	#"platform_broken" = load(platform_sprites_folder + "ground_sand_broken.png"),
	#"platform_small" = load(platform_sprites_folder + "ground_sand_small.png"),
	#"platform_small_broken" = load(platform_sprites_folder + "ground_sand_small_broken.png"),
#}
#
#var platform_textures_snow: Dictionary = {
	#"platform" = load(platform_sprites_folder + "ground_snow.png"),
	#"platform_broken" = load(platform_sprites_folder + "ground_snow_broken.png"),
	#"platform_small" = load(platform_sprites_folder + "ground_snow_small.png"),
	#"platform_small_broken" = load(platform_sprites_folder + "ground_snow_small_broken.png"),
#}
#
#var platform_textures_stone: Dictionary = {
	#"platform" = load(platform_sprites_folder + "ground_stone.png"),
	#"platform_broken" = load(platform_sprites_folder + "ground_stone_broken.png"),
	#"platform_small" = load(platform_sprites_folder + "ground_stone_small.png"),
	#"platform_small_broken" = load(platform_sprites_folder + "ground_stone_small_broken.png"),
#}
#
#var platform_textures_wood: Dictionary = {
	#"platform" = load(platform_sprites_folder + "ground_wood.png"),
	#"platform_broken" = load(platform_sprites_folder + "ground_wood_broken.png"),
	#"platform_small" = load(platform_sprites_folder + "ground_wood_small.png"),
	#"platform_small_broken" = load(platform_sprites_folder + "ground_wood_small_broken.png"),
#}

var platform_textures: Dictionary = {
	#"cake" = platform_textures_cake,
	"grass" = platform_textures_grass,
	#"sand" = platform_textures_sand,
	#"snow" = platform_textures_snow,
	#"stone" = platform_textures_stone,
	#"wood" = platform_textures_wood,
}

func get_platform_texture(environment: String, is_small: bool, is_broken: bool) -> Texture2D:
	# returns the platform texture for the envrionment
	
	var identifier = "platform"
	if is_small:
		identifier += "_small"
	if is_broken:
		identifier += "_broken"
	
	return platform_textures.get(environment, {}).get(identifier, null)
