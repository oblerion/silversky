extends Node3D
var w
var pause:bool = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#w = WeaponManager.createWeapon("blaster",
	#Vector3.ZERO,Vector3.ZERO)
	var player = get_node("player")
	#player.add_child(w)
	player.mesh = ShipManager.getPlayerShip()
	#print(w)
	pass # Replace with function body.

# Called every frame.      'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	if(Input.is_action_pressed("#fire")):
		w.fire(delta)
	if(Input.is_key_pressed(KEY_ESCAPE)):
		pause = !pause
