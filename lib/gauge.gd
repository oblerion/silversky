class_name  Gauge
extends ColorRect
@export var _value:float
@export var max_value = 100
@export var reverse:bool = false
@export var dynamic_color:bool = true
@export var dynamic_color_list := [Color.GREEN_YELLOW,Color.ORANGE,Color.RED]
@export var backcolor:Color = Color(0.196, 0.196, 0.196)
# dynamic_color = false -> use color
# dynamic_color = true -> use dynamic_color_list

var _max_size:Vector2
var _rect2:ColorRect

func SetValue(pvalue:float):
	if(pvalue<max_value):
		_value=pvalue
	else:
		_value=max_value

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_value = 0.0
	_rect2 = ColorRect.new()
	_rect2.size = size
	_rect2.position = Vector2.ZERO
	_rect2.color = color
	color = backcolor
	add_child(_rect2)
	_max_size = size
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	delta = delta
	if(dynamic_color):
		if((float)(_value)>(float)(max_value)/2):
			_rect2.color = dynamic_color_list[0]
		elif((float)(_value)<(float)(max_value)/2 and (float)(_value)>(float)(max_value)/5):
			_rect2.color = dynamic_color_list[1]
		else:
			_rect2.color = dynamic_color_list[2]
			
	if(_max_size.y> _max_size.x):
		_rect2.size.y = _max_size.y*((float)(_value/max_value))
		if(reverse==false):
			_rect2.position.y = (_max_size.y-_rect2.size.y)
	else:
		_rect2.size.x = _max_size.x*((float)(_value/max_value))
		if(reverse==false):
			_rect2.position.x = (_max_size.x-_rect2.size.x)
