# GdUnit generated TestSuite
class_name PlatformTest
extends GdUnitTestSuite
@warning_ignore('unused_parameter')
@warning_ignore('return_value_discarded')

# TestSuite generated from
const __source = 'res://scenes/environment/platform/platform.gd'

var runner: GdUnitSceneRunner

func before():
	runner = scene_runner("res://scenes/environment/platform/platform.tscn") 
	
func test__load_sprite_texture() -> void:
	
	var ignore_test: bool = true
	assert_bool(ignore_test).is_true()
