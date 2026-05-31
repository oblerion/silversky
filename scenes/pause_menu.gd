extends Lnode3D

@export var node:Node3D
var pause:bool = false
func setHide():
	for c in get_children():
		c.hide()
func setShow():
	for c in get_children():
		c.show()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_node("btn_continue").pressed.connect(
		func t(): 
			pause = false
			node.process_mode = Node.PROCESS_MODE_ALWAYS
			setHide()
			node.get_node("Control").show()
	)
	get_node("btn_option").pressed.connect(func t(): pass)
	get_node("btn_title").pressed.connect(func t(): ChangeScene("res://scenes/title.tscn"))
	setHide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta = delta
	if(Input.is_key_pressed(KEY_ESCAPE)):
		if(pause==false):
			pause = true
			node.process_mode = Node.PROCESS_MODE_DISABLED
			node.get_node("Control").hide()
			setShow()
