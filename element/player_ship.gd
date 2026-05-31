class_name  PlayerShip
extends MeshInstance3D
var _tmp_rotY =0
var _movepower =0.0
var _hp = 80
@onready var cam = get_node("../Camera3D")
func moveForward(speed:float,delta:float):
	position.x += sin(cam.rotation.y)*delta*-speed
	position.z += cos(cam.rotation.y)*delta*-speed
func moveBackward(speed:float,delta:float):
	position.x -= sin(cam.rotation.y)*delta*-speed
	position.z -= cos(cam.rotation.y)*delta*-speed
func moveLeft(speed:float,delta:float):
	position.x -= sin(cam.rotation.y-deg_to_rad(45))*delta*-speed
	position.z -= cos(cam.rotation.y-deg_to_rad(45))*delta*-speed
func moveRight(speed:float,delta:float):
	position.x -= sin(cam.rotation.y+deg_to_rad(45))*delta*-speed
	position.z -= cos(cam.rotation.y+deg_to_rad(45))*delta*-speed
# Called when the node enters the scene tree for the first time.
func animRotX():
	var rotydir= rotation.y-_tmp_rotY
	if(rotydir>0):
		rotation.x = deg_to_rad(-15)
	elif(rotydir<0):
		rotation.x = deg_to_rad(15)
	else:
		rotation.x = 0
	_tmp_rotY=rotation.y
func camFollowPlayer():
	cam.position.x = position.x-(sin(cam.rotation.y)*-110)
	cam.position.z = position.z-(cos(cam.rotation.y)*-110)
func getHp()->int:
	return _hp
func getMovePower()->float:
	return _movepower
func _ready() -> void:
	if(cam==null):
		print("WARNING : no try to execute player scene")

# Called every frame. 'delta' is the elapsed time since the previous frame.

func _process(delta: float) -> void:
	if(cam!=null):
		if(Input.is_action_pressed("#move_forward")):#GetMouseY()<=(float)(GetWindowHeight())/2):
			var spdpourcent = 0.5 #1-(GetMouseY()/((float)(GetWindowHeight())/2))
			if(Input.is_action_pressed("#boost")):
				spdpourcent += 0.45
			_movepower = spdpourcent
			moveForward(_movepower*150,delta)
			#print("forward")
		elif(Input.is_action_pressed("#move_backward")):#GetMouseY()>(float)(GetWindowHeight())/2):
			var spdpourcent = 0.5 #(GetMouseY()/((float)(GetWindowHeight())))
			if(Input.is_action_pressed("#boost")):
				spdpourcent += 0.45
			_movepower = spdpourcent
			moveBackward(_movepower*150,delta)
			_movepower = 0-_movepower
			#print("backward")
		else:
			_movepower = 0
		if(Input.is_action_pressed("#move_left")):
			moveLeft(130,delta)
		if(Input.is_action_pressed("#move_right")):
			moveRight(130,delta)
		rotation.y = cam.rotation.y+deg_to_rad(90)
		animRotX()
		camFollowPlayer()
