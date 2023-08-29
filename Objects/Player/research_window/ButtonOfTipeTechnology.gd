extends Button


func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		get_parent().button_pressed(text)
