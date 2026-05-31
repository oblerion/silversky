class_name MESHUTILS
extends Node

func _init() -> void:
	pass
# Fonction pour capturer un MeshInstance3D comme texture
func capture_mesh_icon(mesh_instance: MeshInstance3D) -> Texture2D:
	# Créer un SubViewport
	var viewport = SubViewport.new()
	viewport.size = Vector2(256, 256)
	add_child(viewport)
	#viewport.render_target_update_mode = SubViewport.RENDER_TARGET_UPDATE_ONCE
	#viewport.render_target_clear_mode = SubViewport.RENDER_TARGET_CLEAR_ALWAYS

	# Ajouter une caméra
	var camera = Camera3D.new()
	camera.transform = Transform3D(Basis(), Vector3(0, 0, -2))
	viewport.add_child(camera)

	# Ajouter une lumière
	var light = OmniLight3D.new()
	light.transform = Transform3D(Basis(), Vector3(1, 2, -1))
	viewport.add_child(light)

	# Ajouter une copie du mesh (ou le déplacer temporairement)
	#var mesh_copy = mesh_instance.duplicate()
	viewport.add_child(mesh_instance.duplicate())

	# Ajouter le viewport à la scène
	#get_tree().root.add_child(viewport)

	# Attendre le prochain cadre pour que le rendu soit prêt
	await RenderingServer.frame_post_draw

	# Récupérer l'image du viewport
	var texture = viewport.get_texture()
	var image = texture.get_image()

	# Sauvegarder l'image si besoin (ex: comme PNG)
	image.save_png("res://icons/"+str(mesh_instance.name)+"mesh_icon.png")

	# Convertir en Texture2D utilisable
	var icon_texture = ImageTexture.create_from_image(image)

	# Nettoyer
	viewport.queue_free()

	return icon_texture   
