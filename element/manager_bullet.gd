class_name BulletManager
extends Manager

static var bullet_models:Dictionary[String,Bullet] = BulletManager._readDatabase()
	#"plasma":Bullet.new(5,2,PrismMesh.new(),Material.new())
#}
static func _readDatabase() -> Dictionary[String,Bullet]:
	var _bullet_models:Dictionary[String,Bullet] = {}
	var tab = JSONUTILS.read(
	"res://element/bullets_database.json")
	for key in tab:
		var tbul = tab[key]
		var bul = Bullet.new(tbul["speed"],tbul["lifetime"],tbul["mesh"],tbul["material"])
		_bullet_models.set(key,bul)
		print("add "+key)
	#ajout bul dans dictio
	return _bullet_models

#static func getBullet(pname:String)->Variant:
	#
	#return b

static func createBullet(pname:String,ppos:Vector3,prot:Vector3)->Variant:
	var tab = JSONUTILS.read("res://element/bullets_database.json")
	var tbul = tab.get(pname)
	var bul = Bullet.new(tbul["speed"],tbul["lifetime"],tbul["mesh"],tbul["material"])
	#var b = getBullet(pname).duplicate()
	bul.name = pname
	bul.position = ppos
	bul.rotation = prot 
	addChild(bul)
	return bul 

func _process(delta: float) -> void:
	delta = delta
	#for i in range(bullets_create.size()):
		#get_tree().current_scene.add_child(bullets_create[i])
		#bullets_create.remove_at(i)
	for i in range(size(),0):
		var bul = getChild(i)
		if(bul.lifetime<=0):
			remChild(i)
			get_tree().current_scene.remove_child(bul)
