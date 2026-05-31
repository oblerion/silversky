class_name JSONUTILS
static func tostring(data: Variant) -> String:
	return JSON.stringify(data, "  ", true)
static func todata(json_string: String) -> Variant:
	var json = JSON.new()
	var error = json.parse(json_string)
	if error != OK:
		push_error("Erreur JSON : " + json.get_error_message())
		return null
	return json.data
	
static func read(json_path:String)->Variant:
	var tvar:Variant = null
	if json_path.is_empty()==false:
		var file = FileAccess.open(json_path, FileAccess.READ)
		if file:
			var _content = file.get_as_text()
			file.close()
			tvar = todata(_content)
		else:
			push_error("Erreur lors de l'ouverture du fichier : " + json_path)
	return tvar
static func write(json_path:String,pvar:Variant):
	var tvar:Variant = null
	if json_path.is_empty()==false:
		var file = FileAccess.open(json_path, FileAccess.WRITE)
		if file:
			var tstr = tostring(pvar)
			file.store_string(tstr)
	# écriture
			file.close()
		else:
			push_error("Erreur lors de l'ouverture du fichier : " + json_path)
	return tvar
