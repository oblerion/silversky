extends Tree
class_name MapInput

# MapInput by oblerion studio 2026
# edit/save mapinput

var current_action: String = ""          # Action being remapped
var is_waiting_for_input: bool = false
const ACTION_FILTER:String = "#"
const SAVE_PATH:String = "user://input_mappings.cfg"

func _filter_action(filter:String) -> Dictionary[String, Array]:
	var list_action: Dictionary[String, Array] = {}
	var no_filter:bool = filter.length()==0
	for action_name in InputMap.get_actions():
		if action_name.begins_with(filter) or no_filter:
			var events = InputMap.action_get_events(action_name)
			list_action[action_name] = events.duplicate()
	return list_action
	
func _init_tree(filter:String) -> void:
	var list_action = _filter_action(filter)
	var root = create_item()
	root.set_text(0, "Actions")
	
	for action_name in list_action:
		var display_name = action_name.substr(filter.length())
		var item = create_item(root)
		item.set_text(0, display_name)
		item.set_metadata(0, action_name)  # Store full action name
		
		var events = list_action[action_name]
		if not events.is_empty():
			item.set_text(1, events[0].as_text())
		else:
			item.set_text(1, "—")

func _on_tree_item_selected() -> void:
	var selected = get_selected()
	if selected:
		if is_waiting_for_input==false:
			current_action = selected.get_metadata(0)
			is_waiting_for_input = true
			selected.set_text(1, "Press key...")
			selected.set_custom_color(1, Color.YELLOW)
			print("Remapping: ", current_action, " — Press a key...")

func _load_saved_mappings() -> void:
	var config = ConfigFile.new()
	if config.load(SAVE_PATH) == OK:
		for action_name in config.get_sections():
			if InputMap.has_action(action_name):
				InputMap.action_erase_events(action_name)
				var events = config.get_value(action_name, "events", [])
				for event in events:
					if event:
						InputMap.action_add_event(action_name, event)
	else:
		print("no savestate")

func _save_mappings() -> void:
	var config = ConfigFile.new()
	var list_action = _filter_action(ACTION_FILTER)
	for action_name in list_action:
		var events = list_action[action_name]
		config.set_value(action_name, "events", events)
	var err = config.save(SAVE_PATH)
	if err == OK:
		print("save inputmap complete")
	else:
		push_error("error save inputmap", err)

func _remap_action(action: String, new_event: InputEvent) -> void:
	for old_event in InputMap.action_get_events(action):
		InputMap.action_erase_event(action, old_event)
	InputMap.action_add_event(action, new_event)
	_init_tree(ACTION_FILTER)
	_save_mappings()
	print("Remapped ", action, " to ", new_event.as_text())

func _ready() -> void:
	columns = 2
	_load_saved_mappings()
	_init_tree(ACTION_FILTER)
	item_selected.connect(_on_tree_item_selected)

func _input(event: InputEvent) -> void:
	if is_waiting_for_input and current_action.is_empty()==false:
		# Only handle keys for now (you can extend to joypad/mouse later)
		if event is InputEventKey and event.pressed and not event.is_echo():
			if not event.is_action_pressed("ui_cancel"):
				_remap_action(current_action, event)
			is_waiting_for_input = false
			current_action = ""
			get_tree().reload_current_scene()
