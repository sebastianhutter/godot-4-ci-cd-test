# meta-description: Base template for tower traveller scripts
# meta-default: true

extends _BASE_

# ========
# singleton references
# ========

# ========
# export vars
# ========

# @export var my_export_var: int = 0

# ========
# class signals
# ========

# signal my_custom_signal

# ========
# class onready vars
# ========

# @onready var my_label: Label = $%Label

# ========
# class vars
# ========

# ========
# godot functions
# ========


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta: float) -> void:
	pass

# ========
# signal handler
# ========

func _on_custom_signal_event() -> void:
	pass

# ========
# class functions
# ========
