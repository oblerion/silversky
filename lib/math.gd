extends Node
class_name Math
static func distXY(pos:Vector3,pos2:Vector3) -> float:
	var dx = abs(pos.x-pos2.x)
	var dy = abs(pos.y-pos2.y)
	return dx+dy
static func distXZ(pos:Vector3,pos2:Vector3) -> float:
	var dx = abs(pos.x-pos2.x)
	var dz = abs(pos.z-pos2.z)
	return dx+dz
static func pos3d_to_pos2d(pcam:Camera3D,pos3d:Vector3) -> Vector2:
	return pcam.unproject_position(pos3d)
