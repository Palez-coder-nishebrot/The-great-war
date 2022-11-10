extends Button

export(String) var ideology = ""

func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		get_parent().get_parent().button_pressed(ideology)
