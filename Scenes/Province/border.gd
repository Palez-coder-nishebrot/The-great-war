tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.editor_hint:
		connect("child_entered_tree", self, "_on_border_part_entered")
		for ch in get_children():
			var _err = ch.connect("draw", self, "_on_border_part_editor_draw", [ch])

func _get_configuration_warning():
	var hint = "Border not working without configured BorderPart scenes"
	
	for ch in get_children():
		if ch.name.begins_with("BorderPart"):
			hint = ""
		
	return hint


func _on_border_part_entered(node):
	var _err = node.connect("draw", self, "_on_border_part_editor_draw", [node])


func _on_border_part_editor_draw(node):
	var siblings = []
	
	for ch in get_children():
		if ch != node:
			siblings.append(ch)

	node.correct_corners_snap(siblings)
