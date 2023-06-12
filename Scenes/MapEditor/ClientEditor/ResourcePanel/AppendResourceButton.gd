extends Button


@export var good: Resource
@onready var parent = get_parent().get_parent().get_node("RegionPanel")


func _ready():
	icon = good.icon


func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		parent.region.resources.append(good)
		parent.set_resources()
