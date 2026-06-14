extends Node3D

var pause:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#w = WeaponManager.createWeapon("blaster",
	#Vector3.ZERO,Vector3.ZERO)
	var player:PlayerShip = get_node("player")
	#player.add_child(w)
	ShipManager.new()
	player.mesh = ShipManager.getPlayerShip()
	#print(w)
	player.equipWeapon(0,"canon")
	pass # Replace with function body.

# Called every frame.      'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

	if(Input.is_key_pressed(KEY_ESCAPE)):
		pause = !pause
