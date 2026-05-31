class_name Weapon
extends  MeshInstance3D
#
var bullet_model:String
var timer:float=0
var firerate:int=1

func fire(delta:float):
	if(timer<=0):
		var bul = BulletManager.createBullet(bullet_model,
		position + get_parent().position,
		rotation + get_parent().rotation) 
		get_tree().current_scene.add_child(bul)
		timer = (10*delta)/firerate

func _init(pmesh_path:String,
	pmaterial_path:String,
	pbullet_path:String,
	pfirerate:int) -> void:
	bullet_model = pbullet_path
	firerate=pfirerate
	if(pmaterial_path!=""):
		set_surface_override_material(0,load(pmaterial_path))
	if(pmesh_path!=""):
		mesh = load(pmesh_path)

func _process(delta: float) -> void:
	#if(Input.is_action_pressed("#fire")):
		#fire(delta)
	if(timer>0):
		timer -= delta
