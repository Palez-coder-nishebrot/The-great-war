@tool
extends Line2D

const SNAP_DISTANCE_LIMIT = 10

@export var neighbour_border: NodePath: set = _set_neighbour_border
@export var neighbour_province: NodePath

var _neighbour_border_node
var _neighbour_province_node


func _ready():
#	if not Engine.is_editor_hint():
#		_neighbour_province_node = get_node_or_null(neighbour_province)
#
#		if _neighbour_province_node:
#			_neighbour_border_node = get_node_or_null(neighbour_border)
	pass


func get_border():
	return get_parent()


func get_neighbour_border_node():
	return _neighbour_border_node


func get_neighbour_province_node():
	return _neighbour_province_node


func correct_corners_snap(siblings):
	if points.size() < 2:
		return
	
	var corners = []
	
	for sib in siblings:
		var sib_points = sib.points
		if sib_points.size() > 1:
			corners.append(sib_points[0])
			corners.append(sib_points[-1])
	
	if corners.size() < 2:
		return
	
	var first = _get_point_with_shortest_distance(points[0], corners)
	var last = _get_point_with_shortest_distance(points[-1], corners)
	
	if first != points[0] or last != points[-1]:
		points[0] = first
		points[-1] = last
		points = points


func _get_local_points(target: Line2D) -> PackedVector2Array:
	var target_gp = target.global_position
	var self_gp = global_position
	var local_points = []
	
	for point in target.points:
		local_points.append((point+target_gp) - self_gp)
		
	local_points.invert()
	
	return PackedVector2Array(local_points)


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
	

func _set_neighbour_border(value):
#	if neighbour_border == value:
#		return
#
#	neighbour_border = value
#
#	if not value:
#		return
#
#	var neighbour_bpart = get_node_or_null(value) # border_part
#
#	if not neighbour_bpart:
#		return
#
#	var _neighbour_province = neighbour_bpart.get_border().get_province()
#	neighbour_province = self.get_path_to(_neighbour_province)
#
#	neighbour_bpart.neighbour_border = neighbour_bpart.get_path_to(self)
#	neighbour_bpart.neighbour_province = neighbour_bpart.get_path_to(self.get_border().get_province())
#
#	var new_points =  _get_local_points(neighbour_bpart)
#	points = new_points
	pass
