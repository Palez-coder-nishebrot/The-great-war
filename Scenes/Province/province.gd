tool
extends Node2D


func get_country():
	return get_parent().get_parent()


func get_border():
	return get_node("Border")


func _get_configuration_warning():
	var hint = "Province not working without configured Border scene"
	
	for ch in get_children():
		if ch.name == "Border":
			hint = ""
		
	return hint
