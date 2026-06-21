extends Node3D
class_name Ship_editor

@onready var ship_node:Node3D = $"ship-v2"
@onready var ship: MeshInstance3D = $"ship-v2"
@onready var control = $Control
@onready var colorpick: ColorPicker = $Control/ColorPicker
@onready var btn_reset:Button = $Control/btn_reset

var colorrects: Array[ColorRect] = []
var selected_index: int = 0
@export var save_path: String = "user://ship_custom_colors.tres"  # Fichier de sauvegarde
var data_shipplayer:Data_shipplayer

func _getColors() -> Array[Color]:
	var colors: Array[Color] = []
	if not ship or not ship.mesh:
		return colors
		
	var surface_count = ship.mesh.get_surface_count()
	for i in surface_count:
		var mat = ship.get_surface_override_material(i)
		if not mat:  # Si pas d'override, on prend le matériau de base
			mat = ship.mesh.surface_get_material(i)
		
		if mat:
			colors.append(mat.albedo_color)
		else:
			colors.append(Color.WHITE)
	return colors


func _setColor(index: int, color: Color) -> void:
	if not ship or not ship.mesh:
		return
		
	var surface_count = ship.mesh.get_surface_count()
	if index >= surface_count:
		return
	
	# Récupérer ou créer un matériau d'override
	var mat = ship.get_surface_override_material(index)
	if not mat:
		var base_mat = ship.mesh.surface_get_material(index)
		if base_mat:
			mat = base_mat.duplicate()  # Très important !
		else:
			mat = StandardMaterial3D.new()
	
	mat.albedo_color = color
	ship.set_surface_override_material(index, mat)

func reset_color():
	for i in range(0,ship.mesh.get_surface_count()):
		ship.set_surface_override_material(i,null)
	var colors = _getColors()
	data_shipplayer = Data_shipplayer.new(colors)
	var _i=0
	for col in colors:
		colorrects[_i].color = col
		_i += 1

func _ready() -> void:
	load_colors()
	if not ship or not ship.mesh:
		push_error("Ship ou mesh non assigné")
		return
		
	var colors = data_shipplayer.colors
	
	for i in colors.size():
		var colorrec = ColorRect.new()
		colorrec.color = colors[i]
		var lsize = 50
		colorrec.position.x = 15
		colorrec.position.y = 15 + i * lsize * 1.2
		colorrec.size = Vector2(lsize,lsize)
		
		# Meilleure façon de capturer l'index
		colorrec.mouse_entered.connect(func():
			colorpick.color = colorrec.color
			selected_index = i
		)
		
		control.add_child(colorrec)
		colorrects.append(colorrec)
	
	colorpick.color_changed.connect(_on_color_changed)
	btn_reset.pressed.connect(func t(): reset_color())

func _process(delta: float) -> void:
	if Input.is_key_pressed(KEY_Q):
		ship_node.rotation += Vector3(0,2*delta,0)
	if Input.is_key_pressed(KEY_D):
		ship_node.rotation -= Vector3(0,2*delta,0)
func _on_color_changed(new_color: Color) -> void:
	if selected_index >= colorrects.size():
		return
		
	# Mise à jour visuelle du ColorRect
	colorrects[selected_index].color = new_color
	data_shipplayer.colors[selected_index] = new_color
	
	# Mise à jour réelle du mesh
	_setColor(selected_index, new_color)
	save_colors()
	
func save_colors() -> void:
	if not data_shipplayer:
		return
	ResourceSaver.save(data_shipplayer, save_path)
	print("Couleurs sauvegardées : ", save_path)


func load_colors() -> void:
	if ResourceLoader.exists(save_path):
		data_shipplayer = ResourceLoader.load(save_path)
		print("Couleurs chargées depuis le fichier")
	else:
		# Première fois : on récupère les couleurs par défaut du mesh
		var default_colors = _getColors()
		data_shipplayer = Data_shipplayer.new(default_colors)
		print("Nouveau fichier de couleurs créé")
	
	# Appliquer les couleurs au mesh
	for i in data_shipplayer.colors.size():
		_setColor(i, data_shipplayer.colors[i])
