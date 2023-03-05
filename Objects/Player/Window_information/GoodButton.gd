extends Button

onready var parent = get_parent().get_parent()
export(Resource) var good


func _ready():
	icon = good.icon


func _input(_event):
	if pressed == true:
		parent.showing_good = good
		parent.set_showing_map()
