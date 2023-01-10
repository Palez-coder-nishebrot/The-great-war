tool
extends Line2D

const SNAP_DISTANCE_LIMIT = 25

export(NodePath) var neighbour_province


func _ready():
	pass


func correct_corners_snap(siblings):
	if points.size() < 2:
		return
	
	var corners = []
	
	for sib in siblings:
		var sib_points = sib.points
		if sib_points.size() > 1:
			corners.append(sib_points[0])
			corners.append(sib_points[-1])
	
	var first = _get_point_with_shortest_distance(points[0], corners)
	var last = _get_point_with_shortest_distance(points[-1], corners)
	
	if first != points[0] or last != points[-1]:
		points[0] = first
		points[-1] = last
		points = points


func _get_point_with_shortest_distance(current_point, corners):
	var shorter_distance
	var new_point
	
	for corner in corners:
		var test_distance = current_point.distance_to(corner)
		
		if not shorter_distance or test_distance < shorter_distance:
			new_point = corner
			shorter_distance = test_distance
		
	if shorter_distance <= SNAP_DISTANCE_LIMIT:
		return new_point
	else:
		return current_point
	
