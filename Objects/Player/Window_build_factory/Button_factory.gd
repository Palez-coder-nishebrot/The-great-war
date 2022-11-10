extends Button

var parent: Object 


func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		parent.check_factory(text)
