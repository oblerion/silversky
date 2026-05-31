extends Lnode3D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("btn_back2").pressed.connect(func t(): ChangeScene("res://scenes/title.tscn"))
	pass # Replace with function body.
	
#func _input(event: InputEvent) -> void:
	#if MouseIsDown(event,MouseButtonLeft):
		#ChangeScene("res://scenes/title.tscn")
