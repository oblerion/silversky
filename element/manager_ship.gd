class_name ShipManager
extends Manager

static var ships_id:Array[String] = _loadDatabase()
static var player_ship:String =""

static func _loadDatabase()->Array[String]:
	var _list_id:Array[String] = []
	var json = JSONUTILS.read("res://element/ships_database.json")
	for key in json:
		var ship = load(json[key])
		if(player_ship.is_empty()):
			ShipManager.player_ship= key
		_list_id.push_back(key)
		addChild(ship)
	return _list_id
# Called when the node enters the scene tree for the first time.
static func getShip(pname:String)->Variant:
	var s:Variant = null
	var i=0
	for e in ships_id:
		if(pname==e):
			s = getChild(i)
			break
		i += 1
	return s
static func getPlayerShip()->Variant:
	return getShip(ShipManager.player_ship)
static func setPlayer(key:String):
	if(getShip(key)!=null):
		ShipManager.player_ship = key
#func _ready() -> void:
		#ShipManager.ships_id = _loadDatabase()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
