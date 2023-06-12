extends Button


@export var name_of_factory: String = ""
@onready var parent = get_parent().get_parent().get_node("RegionPanel")

func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		if name_of_factory != "":
			parent.region.list_of_buildings.append(name_of_factory)
			parent.set_factories()
