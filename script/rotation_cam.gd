extends Lnode3D

@export var mouse_sensitivity := 0.08    # radians par pixel – ajuste selon ton goût
@export var vertical_rotation_limit := 50 # en degrés
func _rotatemouseX(event):
	if event is InputEvent:	
		#Rotation verticale (sur la tête / le bras caméra)
		var vertical_rotation = 0
		vertical_rotation -= event.relative.y * mouse_sensitivity
		vertical_rotation = clamp(vertical_rotation, deg_to_rad(-vertical_rotation_limit), deg_to_rad(vertical_rotation_limit))
		#Option A – la plus simple et sans décalage (recommandée)
		rotation.x = vertical_rotation

func _rotatemouseY(delta:float):
	var dt = delta*1.8
	var rotY:float = 0.0
	var prc:float = GetMouseX() / (float)(GetWindowWidth()) 
	if(prc<0.45):
		rotY += 0.45-prc
	elif(prc>0.55):
		rotY -= prc-0.5
	if(rotY!=0.0):
		rotate_y(2*rotY*deg_to_rad(60)*dt)

func _process(delta: float) -> void:
	_rotatemouseY(delta)
	pass
