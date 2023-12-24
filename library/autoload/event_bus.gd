extends Node
class_name EventBusSingleton

# ========
# singleton references
# ========

# ========
# export vars
# ========

# ========
# class signals
# ========

# game state signals
signal play_game_requested()
signal quit_game_requested()
signal pause_game_requested()
signal continue_game_requested()
signal return_to_main_menu_requested()

# escape key presses, will always be handled by the menu or ui manager
# the escape key is handled as unhandled input in the game manager
# which should ensure that the escape key is always handled
signal escape_key_pressed()

# ========
# class onready vars
# ========


# ========
# class vars
# ========

# ========
# godot functions
# ========

# ========
# signal handler
# ========

# ========
# class functions
# ========

