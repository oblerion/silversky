class_name Bullet
extends MeshInstance3D
@export var lifetime:float = 0.0
@export var speed:float = 0.0
@export var damage:int = 1

func set_target(ppos:Vector3,ptarget:Vector3):
	position = ppos 
	rotation.y = atan2(abs(ptarget.x-position.x),abs(ptarget.z-position.z))
# Called when the node enters the scene tree for the first time.
func _init(pspeed:float,plifetime:float,pmesh:String,pmaterial:String):
	name="bullet"
	speed = pspeed 
	lifetime = plifetime
	if(pmesh!=""):
		mesh = load(pmesh)
	if(pmaterial!=""):
		set_surface_override_material(0,load(pmaterial))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(lifetime>0):
		position.x += sin(rotation.y)*speed*delta
		position.z += cos(rotation.y)*speed*delta
		lifetime -= delta
	else:
		pass #get_tree().current_scene.remove_child(self)
