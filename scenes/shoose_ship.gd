extends Lnode3D
var ship_list := []
var weapon_list := []
var ship_id := 0
@onready var btn_back = get_node("Control/btn_back")
@onready var btn_select = get_node("Control/btn_select")
@onready var btn_last:Button = get_node("Control/btn_-")
@onready var btn_next:Button = get_node("Control/btn_+")

func _loadships()->Array[MeshInstance3D]:
	var _ship_list:Array[MeshInstance3D] = []
	var json = JSONUTILS.read("res://element/ships_database.json")
	var zoff = 0
	for key in json:
		var meshinst := MeshInstance3D.new()
		meshinst.mesh = ShipManager.getShip(key)
		meshinst.name = key
		meshinst.position = Vector3(0,0,zoff)
		meshinst.rotation_degrees.y = 130
		var label = Label3D.new()
		label.position.y = -30
		label.rotation.y = deg_to_rad(360-meshinst.rotation_degrees.y)+deg_to_rad(-90)
		label.text = key
		label.font = load("res://asset/fonts/Softball_Gold.ttf")
		label.font_size = 1200
		meshinst.add_child(label)
		_ship_list.push_back(meshinst)
		add_child(meshinst)
		zoff += 100
	return _ship_list
func _loadweapons()->Array[MeshInstance3D]:
	var _weapon_list:Array[MeshInstance3D]
	var json = JSONUTILS.read("res://element/weapons_database.json")
	var offz = 0
	for key in json:
		var w = WeaponManager.createWeapon(key,
		Vector3(-50,70,offz),Vector3.ZERO)
		_weapon_list.push_back(w)
		add_child(w)
		offz += 100
	return _weapon_list

func _update_ship_position(ship_list: Array[MeshInstance3D], highlighted_id: int) -> void:
	if ship_list.is_empty()==false:
		var n := ship_list.size()
		var angle_step := 360.0 / n          # angle entre chaque vaisseau
		for i in n:
			# On décale tout le cercle pour que le vaisseau highlighted_id soit en position "principale" (angle 0)
			var angle := (i - highlighted_id) * angle_step
			var rad := deg_to_rad(-80+angle)
			var radius := 100.0
			var ship := ship_list[i]
			ship.position.x = sin(rad) * radius
			ship.position.z = cos(rad) * radius
			# ship.position.y = 0  # si tu veux forcer Y à 0

func _ready() -> void:
	btn_back.pressed.connect(func t(): ChangeScene("res://scenes/title.tscn"))
	btn_select.pressed.connect(
		func t(): 
			ChangeScene("res://scenes/chapterselect.tscn")
	)
	btn_last.pressed.connect(
		func t(): 
			if(ship_id>0):
				ship_id -= 1
			else:
				ship_id = ship_list.size()-1
			ShipManager.setPlayer(ship_list[ship_id].name)
			_update_ship_position(ship_list,ship_id)
	)
	btn_next.pressed.connect(
		func t():
			if(ship_id+1<ship_list.size()):
				ship_id += 1
			else:
				ship_id = 0
			ShipManager.setPlayer(ship_list[ship_id].name)
			_update_ship_position(ship_list,ship_id)
	)

	ship_list = _loadships()
	#weapon_list = _loadweapons()
	_update_ship_position(ship_list,ship_id)
	ShipManager.setPlayer(ship_list[ship_id].name)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
