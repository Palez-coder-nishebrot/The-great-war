extends Button

var parent:  Object 
var factory


func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		parent.show_factory_info(factory)
