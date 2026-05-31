class_name Manager
extends Node3D

static var _list:Array[Variant] = []

static func addChild(v:Variant):
	_list.push_back(v) 
static func remChild(id:int):
	_list.remove_at(id)
static func getChild(id:int)->Variant:
	if(id>-1 and id<_list.size()):
		return _list[id]
	return null
static func size()->int:
	return _list.size()
