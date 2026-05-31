class_name DataBaseViewer
extends Tree
@export var json_database:JSON
var tab_database:Dictionary = {}
#@onready var tree:Tree = get_node("Tree")

func _readDatabase():
	tab_database = JSONUTILS.read(json_database.resource_path)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_readDatabase()
	var root = create_item()
	hide_root = true
	for key in tab_database:
		#list.add_item(key,null,true)
		#list.set_item_metadata(list.get_item_count() - 1,tab_bullets[key])
		var child1 = create_item(root)
		child1.set_text(0, key)
		for bkey in tab_database[key]:
			var c = create_item(child1)
			c.set_text(1,bkey)
			var value = tab_database[key][bkey]
			if(type_string(typeof(value)) != "String"):
				value = str(value)
			c.set_text(2,value)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass                     
	var t = get_selected()
	if(t):
		print(t.get_text(1))
	#var array = list.get_selected_items()
	#for i in array:
		#if(list.is_selected(i)):
			#var meta = list.get_item_metadata(i)
			#for key in meta:
				#print(key," ",meta[key])
