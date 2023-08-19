extends ScrollContainer


func _ready():
	spawn_buttons()


func spawn_buttons():
	var folder = DirAccess.open("res://Resources/StatesOnStartGame/States/")
	var _err_ = folder.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	var folder_name = folder.get_next()
	
	while folder_name != "":
		var path = "res://Resources/StatesOnStartGame/States/" + folder_name
		var file = load(path)
		set_client_button(file)
		folder_name = folder.get_next()
		


func set_client_button(file):
	var button = $VBoxContainer/Button.duplicate()
	button.visible = true
	button.file = file
	button.text = file.name_of_state
	$VBoxContainer.add_child(button)
