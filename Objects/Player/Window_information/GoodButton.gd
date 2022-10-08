extends Button

onready var parent = get_parent().get_parent()
export(String) var good = ""


func _input(event):
	if pressed == true:
		parent.showing_good = good
		parent.set_showing_map()
