tool
extends Node2D


var _parts = []


func get_province():
	return get_parent()


func get_parts():
	return get_children()


func remove_parts():
	for p in get_parts():
		remove_child(p)


func restore_parts():
	for p in _parts:
		if not p.is_inside_tree:
			add_child(p)


func get_country_points():
	var country_parts = []
	var self_province = get_province()
	var self_country = self_province.get_country()

	for p in _parts:
		var neighbour_province = p.get_neighbour_province_node()
		if not neighbour_province or self_country != neighbour_province.get_country():
			var arr = []
			
			for point in p.points:
				arr.append(point+p.position+position+self_province.position)
			
			country_parts.append(arr)
		
	return country_parts


func _enter_tree():
	if not Engine.editor_hint:
		for ch in get_children():
			_parts.append(ch)
			ch.hide()


func _ready():
	if Engine.editor_hint:
		var _err = connect("child_entered_tree", self, "_on_border_part_entered")
		for ch in get_children():
			_err = ch.connect("draw", self, "_on_border_part_editor_draw", [ch])


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
