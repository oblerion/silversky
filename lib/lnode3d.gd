class_name Lnode3D
extends Node3D
# custom node

func GetWindowWidth() ->int:
	return (int)(get_viewport().get_visible_rect().size.x)
func GetWindowHeight() ->int:
	return (int)(get_viewport().get_visible_rect().size.y)
func GetWindowCenter() ->Vector2:
	return get_viewport().get_visible_rect().size/2
func ChangeScene(path:String):
	get_tree().change_scene_to_file(path)
	
const MouseButtonLeft = 1
const MouseButtonRight =  2
const MouseButtonMidd = 3
func MouseIsDown(event:InputEvent,id:int) -> bool:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				if(id==1):
					return true
			MOUSE_BUTTON_RIGHT:
				if(id==2):
					return true
			MOUSE_BUTTON_MIDDLE:
				if(id==3):
					return true
	return false
func GetMouseX() -> float:
	return get_viewport().get_mouse_position().x
func GetMouseY() -> float:
	return get_viewport().get_mouse_position().y
