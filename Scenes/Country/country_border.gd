extends Line2D


func get_country():
	return get_parent()


func _ready():
	_create_border()
	
	
func _create_border():
	yield(get_tree(), "idle_frame")
	
	var border_points = []
	var country = get_country()
	
	default_color = country.national_color
	
	# collect all points
	for province in country.get_provinces():
		var border = province.get_border()
		var country_points = border.get_country_points() # Array of points array
		
		for point_arr in country_points:
			border_points.append(point_arr)
	
	# order points
	var ordered_border_points = []
	
	ordered_border_points.resize(border_points.size())
	ordered_border_points[0] = border_points[0]
	
	for iterator in range(ordered_border_points.size() - 1):
		for point_arr in border_points:
			if ordered_border_points[iterator].back() == point_arr.front():
				ordered_border_points[iterator+1] = point_arr
				break
	
	# glue points
	var summary_line = []
	
	for ordered_points_item in ordered_border_points:
		var _nullptr = ordered_points_item.pop_back()
		summary_line += ordered_points_item
		
	summary_line.append(summary_line[0])
	
	points = summary_line
