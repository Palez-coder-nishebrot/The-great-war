extends Button


func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		get_parent().button_pressed(text)
		  # etc
