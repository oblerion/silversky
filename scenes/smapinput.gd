extends Node3D

@onready var btn_back: Button = $Control/button_back

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	btn_back.pressed.connect(
		func(): 
			get_tree().change_scene_to_file("res://scenes/title.tscn")
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
