extends Button


export(String) var name_of_factory = ""
var parent 

func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		if name_of_factory != "":
			parent.region.list_of_buildings.erase(name_of_factory)
			parent.set_factories()