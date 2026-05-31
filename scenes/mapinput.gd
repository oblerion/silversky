extends Lnode3D
# Called when the node enters the scene tree for the first time.
var list_action:Dictionary[String,Array] = {}
var action_select:String=""
var remap = ControlsRemap.new()
@onready var tree:Tree = get_node("Control/Tree")
@onready var control = get_node("Control")
@onready var btn_back = get_node("Control/button_back")

func _update_action():
	list_action.clear()
	for actionName in InputMap.get_actions():
		if(actionName.substr(0,1) == '#'):
			#print("%s" % actionName.substr(1))
			var arr:Array[InputEvent] = InputMap.action_get_events(actionName)
			#arr.push_back(inputEvent)
			##print("  %s" % inputEvent.as_text())
			#if(arr[0].type == InputEvent):
				#print(arr[0].as_text())
			list_action.set(actionName,arr)
	#print(list_action)

func _ready() -> void:
	btn_back.pressed.connect(func t(): ChangeScene("res://scenes/title.tscn"))
	_update_action()
	#_update_buttons()
	var base = tree.create_item()
	base.set_text(0,"base")
	for key in list_action:
		var str_action = key.substr(1)
		var str_event = list_action[key][0].as_text()
		var tree_action = tree.create_item(base)
		tree_action.set_text(0,str_action)
		tree_action.set_text(1,str_event)
func _input(event: InputEvent) -> void:
	pass
	#if(action_select.is_empty()==false):
		#if event is InputEventKey:
			#remap.set_action_key(action_select, event)
			#remap.create_remap()
			##ResourceSaver.save(remap,"user://my_remap.tres")
			#action_select = ""
			#_update_action()
			#_update_buttons()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var t = tree.get_selected()
	if(t):
		var event:InputEvent = list_action["#"+t.get_text(0)][0]
		#print(event.keycode)
