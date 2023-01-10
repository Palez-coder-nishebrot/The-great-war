tool
extends Line2D

export(NodePath) var neighbour_province


func _ready():
	if Engine.editor_hint:
		var _err = connect("draw", self, "_on_editor_draw")


func _on_editor_draw():
	var siblings = get_parent().get_children().erase(self)
	
	var closest_start = null
	var closest_end = null
	
	for sib in siblings:
		var sib_points = sib.points
		if sib_points.length > 1:
			var first = sib_points[0]
			var last = sib_points[-1]
			closest_start = _get_shorter_distance(closest_start, first)
			closest_start = _get_shorter_distance(closest_start, last)
			closest_end = _get_shorter_distance(closest_end, first)
			closest_end = _get_shorter_distance(closest_end, last)


func _get_shorter_distance(current, next):
	pass
