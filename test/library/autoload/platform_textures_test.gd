# GdUnit generated TestSuite
class_name PlatformTexturesSingletonTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://library/autoload/platform_textures.gd'

#var singleton: PlatformTexturesSingleton

func test_get_platform_texture_unknown() -> void:
	var texture = PlatformTextures.get_platform_texture("this_does_not_exist", false, false)
	assert_that(texture).is_null()

func test_get_platform_texture() -> void:
	
	var texture = PlatformTextures.get_platform_texture("grass", false, false)
	assert_that(texture).is_class("Texture2D")
