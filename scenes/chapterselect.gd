extends Lnode3D

@onready var chap1 = get_node("chap1")
@onready var ship = get_node("ShipVox")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ship.mesh = ShipManager.getPlayerShip()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event: InputEvent) -> void:
	var dxy = Math.distXY(chap1.position,ship.position)
	if(MouseIsDown(event,MouseButtonLeft)):
		if(dxy<4):
			ChangeScene("res://scenes/boss_fight.tscn")
