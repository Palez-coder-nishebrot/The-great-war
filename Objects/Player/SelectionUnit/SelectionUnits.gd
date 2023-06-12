extends Area2D

var dragging = false

@onready var shape: CollisionShape2D = $CollisionShape2D
var old_pos

var list_of_units: Array = []

#func _input(event):
#	if Players.player.information.showing_map == true:
#		if Input.is_action_pressed("mouse_left"):
#			if dragging == false:
#				shape.global_position = get_global_mouse_position()
#				old_pos = shape.global_position
#			dragging = true
#			update()
#		elif Input.is_action_just_released("mouse_left"):
#			dragging = false
#			shape.shape.extents = Vector2(0, 0)
#			append_units()
			

func update():
	shape.global_position.x = old_pos.x + shape.shape.size.x
	shape.global_position.y = old_pos.y + shape.shape.size.y

	if get_global_mouse_position().x > position.x + shape.shape.size.x:
		shape.shape.size.x = (get_global_mouse_position().x - old_pos.x) / 2

	if get_global_mouse_position().y > position.y + shape.shape.size.y:
		shape.shape.size.y = (get_global_mouse_position().y - old_pos.y) / 2
		
	
#	var shape_pos_x = old_pos.x
#	var mouse_pos_x = get_global_mouse_position().x 
#	var answer_x = (mouse_pos_x - shape_pos_x)
#	shape.shape.extents.x = answer_x
#
#	var shape_pos_y = old_pos.y
#	var mouse_pos_y = get_global_mouse_position().y
#	var answer_y = (mouse_pos_y - shape_pos_y)
#	shape.shape.extents.y = answer_y


func append_units():
	if list_of_units.size() != 0:
		Players.player.list_of_active_units.clear()
		Players.player.list_of_active_units.append_array(list_of_units)
		Players.player.window_list_of_units.show_units()


func area_entered(area):
	if area.get_parent().get_groups().has("Province"):
		
		for i in area.get_parent().list_of_units:
			if i.player == Players.player:
				list_of_units.append(i)


func area_exited(area):
	if area.get_parent().get_groups().has("Province"):
		
		for i in area.get_parent().list_of_units:
			if i.player == Players.player:
				list_of_units.erase(i)
