extends Control
 
# "adapted" (<3) from: http://docs.godotengine.org/en/latest/tutorials/2d/custom_drawing_in_2d.html
var center = Vector2(200, 200)
var radius = 80
var mouse_in = false
 
var tooltip
var tooltip_offset = Vector2(20,20)
 
var regions = {
	"socialists": 15.0,
	"communists": 5.0,
	
	"liberals": 30.0,
	"libertarians": 5.0,
	
	"conservators": 45.0,
	"fascists": 0.0, 
}
var sum_regions = null
var region_angles = {}
 
# maybe you'll have a separate data struct that has
# a party's color information instead
var colors = [Color(1, 0, 0), Color(0.554688, 0.133797, 0.133797), Color(0.992157, 1, 0), Color(0.707031, 0.679413, 0),
	Color(0.16222, 0.304783, 0.683594), Color(0.253906, 0.132776, 0.044384)]
 
#Красный, бурый, желтый, смугло-желтый, синий, коричневый
func _ready():
	# set up your custom tooltip here (if necessary)
	tooltip = Label.new()
	add_child(tooltip)
 
#func _process(delta):
#	#update() # triggers _draw() if you want to update regions in realtime
#	pass
#
#func _input(event):
#	if event is InputEventMouseMotion:
#		var pos = event.global_position
#		if not mouse_in:
#			if within_circle(pos.x, pos.y):
#				mouse_in = true
#				tooltip.visible = true
#		else:
#			if not within_circle(pos.x, pos.y):
#				mouse_in = false
#				tooltip.visible = false
#			else:
#				# set & reposition tooltip
#				tooltip.text = get_region(pos.x, pos.y)
#				tooltip.rect_global_position = pos + tooltip_offset
#
#func get_region(x,y):
#	var angle_to_mouse = rad2deg(atan2(x-center.x,center.y-y))
#	if angle_to_mouse < 0:
#		angle_to_mouse = 360 + angle_to_mouse
#
#	for region in region_angles:
#		var region_start = region_angles[region].x
#		var region_end = region_angles[region].y
#
#		# might want to play with >= / > or <= / < to fine tune behavior
#		if angle_to_mouse >= region_start and angle_to_mouse <= region_end:
#			return region
#
#	return ''
 
func draw_chart_from_regions():
	sum_regions = 0
	var regions_to_draw = []
	for region in regions:
		var val = regions[region]
		sum_regions += val
		if val > 0:
			regions_to_draw.append(region)
 
	var angle_from = 0
	var angle_to = 0
	var color_index = 0
	for region in regions_to_draw:
		angle_to += (regions[region] / sum_regions) * 360.0
		draw_circle_arc_poly(center, radius, angle_from, angle_to, colors[color_index])
		region_angles[region] = Vector2(angle_from,angle_to)
		angle_from = angle_to
		color_index += 1
 
# directly from: http://docs.godotengine.org/en/latest/tutorials/2d/custom_drawing_in_2d.html
func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
	var nb_points = 32
	var points_arc = PoolVector2Array()
	points_arc.push_back(center)
	var colors = PoolColorArray([color])
 
	for i in range(nb_points+1):
		var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
		points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
	draw_polygon(points_arc, colors)
 
func within_circle(x,y):
	return pow(x-center.x,2) + pow(y - center.y,2) < pow(radius,2)
 
func _draw():
	draw_chart_from_regions()
