@tool
extends Node2D

func get_country():
	return get_parent().get_parent()


func get_border():
	return get_node("Border")


func _get_configuration_warnings():
	var Helper = preload("res://gd_scripts/tool_node_helper.gd")
		
	return Helper.detect_children([
		Helper.create_detect_mask("Border", "Province not working without configured Border scene"),
		Helper.create_detect_mask("MapNameLabel", "Province not working without configured MapNameLabel scene")
	], get_children())
