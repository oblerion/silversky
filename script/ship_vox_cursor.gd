extends Node3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position.x = 0
	position.y = 0

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta = delta
	var mouse_pos = get_viewport().get_mouse_position()
	position = get_viewport().get_camera_3d().project_position(mouse_pos,3)
