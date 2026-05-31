extends Lnode3D
@onready var btn_start:Button = get_node("Button_start")
@onready var btn_option:Button = get_node("Button_option")
@onready var btn_credit:Button = get_node("Button_credit")
# Called when the node enters the scene tree for the first time.

func _setAnimButton(b:Button):
	var posx = b.position.x
	b.mouse_entered.connect(
		func t(): 
			var curant_posx = b.position.x
			var anim_posx = posx+30
			if(curant_posx!=anim_posx):
				b.position.x = anim_posx
	)
	b.mouse_exited.connect(
		func t():
			var curant_posx = b.position.x
			if(curant_posx!=posx):
				b.position.x = posx
	)
func _ready() -> void:
	btn_start.pressed.connect(func t(): ChangeScene("res://scenes/shoose_ship.tscn"))
	btn_option.pressed.connect(func t(): ChangeScene("res://scenes/mapinput.tscn"))
	btn_credit.pressed.connect(func t(): ChangeScene("res://scenes/credit.tscn"))
	
	_setAnimButton(btn_start)
	_setAnimButton(btn_option)
	_setAnimButton(btn_credit)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
