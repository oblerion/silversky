class_name Weapon
extends  MeshInstance3D
#
var bullet_model:String
var timer:float=0
var firerate:int=1

func fire(delta:float):
	if(timer<=0):
		var roty:float = rotation.y + get_parent().rotation.y + deg_to_rad(90)
		var bul:Bullet = BulletManager.createBullet(bullet_model,
		position + get_parent().position + Vector3(sin(roty)*30,0,cos(roty)*30),
		Vector3(0,roty,0))
		#bul.set_target()
		get_tree().current_scene.add_child(bul)
		timer = (10*delta)/firerate

static func copy(pweapon:Weapon)->Weapon:
	var w:Weapon = Weapon.new("","","",0)
	w.mesh = pweapon.mesh
	w.bullet_model = pweapon.bullet_model
	w.firerate = pweapon.firerate
	return w

func _init(pmesh_path:String,
	pmaterial_path:String,
	pbullet_path:String,
	pfirerate:int) -> void:
	bullet_model = pbullet_path
	firerate=pfirerate
	if(pmesh_path!=""):
		mesh = load(pmesh_path)

func _process(delta: float) -> void:
	#if(Input.is_action_pressed("#fire")):
		#fire(delta)
	if(timer>0):
		timer -= delta
