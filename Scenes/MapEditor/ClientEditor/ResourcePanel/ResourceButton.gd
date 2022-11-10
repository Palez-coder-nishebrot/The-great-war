extends Button


var good: String = ""
var parent: Object

func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		parent.region.resources.erase(good)
		parent.set_resources()
