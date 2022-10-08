extends ScrollContainer


func _ready():
	spawn_buttons()


func spawn_buttons():
	
	var folder: Directory = Directory.new()
	folder.open("res://Resources/StatesOnStartGame/States/")
	folder.list_dir_begin(true, true)
	var folder_name = folder.get_next()
	
	while folder_name != "":
		var file = load("res://Resources/StatesOnStartGame/States/" + folder_name)
		set_client_button(file.name_of_state)
		folder_name = folder.get_next()
		


func set_client_button(state):
	var button = $VBoxContainer/Button.duplicate()
	button.visible = true
	button.text = state
	$VBoxContainer.add_child(button)
