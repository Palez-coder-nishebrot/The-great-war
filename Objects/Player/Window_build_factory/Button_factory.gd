extends Button

var parent:  Object 
var factory: Node


func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		parent.show_factory_info(factory)
