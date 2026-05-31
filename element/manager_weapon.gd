class_name WeaponManager
extends Manager

static var models:Dictionary[String,Weapon] = WeaponManager._readDatabase()
	#"plasma":Bullet.new(5,2,PrismMesh.new(),Material.new())
#}
static func _readDatabase() -> Dictionary[String,Weapon]:
	var _models:Dictionary[String,Weapon] = {}
	var tab = JSONUTILS.read(
	"res://element/weapons_database.json")
	for key in tab:
		var tw = tab[key]
		var w = Weapon.new(tw["mesh"],tw["material"],tw["bullet"],tw["firerate"])
		_models.set(key,w)
	return _models

static func createWeapon(pname:String,ppos:Vector3,prot:Vector3)->Weapon:
	if(models.has(pname)):
		var w = models.get(pname)
		w.position = ppos
		w.rotation = prot
		return w
	return null
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
