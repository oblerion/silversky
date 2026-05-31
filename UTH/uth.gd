extends Control
@export var player : PlayerShip
@onready var hpbar = get_node("./HPBar")
@onready var cursor = get_node("./cursor")
@onready var movebar_test := [
	get_node("MoveBar_test"),
	get_node("MoveBar_test2")
]
var scry_midd = 0
func _ready() -> void:
	scry_midd = get_viewport().get_visible_rect().size.y/2
	#updatedraw(player.getHp()-50,100)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	#if(player.getHp()>50):
		#hpbar.color = Color.GREEN_YELLOW
	#elif(player.getHp()<50 and player.getHp()>20):
		#hpbar.color = Color.ORANGE
	#else:
		#hpbar.color = Color.RED
	#hpbar.size.y = 580*((float)(player.getHp())/100)
	#hpbar.position.y = 40+(580-hpbar.size.y)
	#
	hpbar.SetValue(player.getHp())
	if(player.getMovePower()>0):
		movebar_test[0].SetValue(player.getMovePower()*100)
		movebar_test[1].SetValue(0)
	elif(player.getMovePower()<0):
		movebar_test[1].SetValue((0-player.getMovePower())*100)
		movebar_test[0].SetValue(0)
	else:
		movebar_test[0].SetValue(0)
		movebar_test[1].SetValue(0)
		
	#var cam = get_viewport().get_camera_3d()
	#var pos3d_cursor = player.position
	#pos3d_cursor.x = sin(player.rotation.y)*40
	#pos3d_cursor.z = cos(player.rotation.y)*40
	#var pos2d_cursor = cam.unproject_position(pos3d_cursor)
	#cursor.position = pos2d_cursor
