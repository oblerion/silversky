extends Lnode3D
@export var cam:Camera3D
var distXZ = 0
func camFollow():
	position.x = cam.position.x+(sin(cam.rotation.y)*-distXZ)
	position.z = cam.position.z+(cos(cam.rotation.y)*-distXZ)
	rotation.y = cam.rotation.y

func _ready() -> void:
	distXZ = Math.distXZ(position,cam.position)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	camFollow()
