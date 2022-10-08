extends Node2D


var list_of_lines:              Array      = []

var list_of_neighbors_tiles:    Array      = []
var list_of_units:              Array      = []
var list_of_households:         Array      = []
var goods_of_factories_in_province: Array  = []

var name_of_tile:        String
var landscape:           String = "Степь"
var player:              Object

var resources:              Dictionary = {}
var administration:         Dictionary = {}
var railways:               Object = load("res://Objects/Building/Railways.gd").new()
var infrastructure:         Object = load("res://Objects/Building/Infrastructure.gd").new()
var population_manager:     Object


func start():
	name_of_tile = name
	update_text_on_label()


func input(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			Players.player.window_province.update_information(self, "village")
		
		elif event.button_index == BUTTON_RIGHT:
			if Players.player.get_groups().has("Human"):
				Functions.set_point_of_units(self, Players.player.list_of_active_units)
			else:
				Players.player.window_province.set_path(self)


func new_owner(new_owner):
	player.list_of_tiles.erase(self)
	for i in list_of_households:
		player.list_of_soc_classes.erase(i)
	
	player = new_owner
	player.list_of_tiles.append(self)
	
	for i in list_of_households:
		player.list_of_soc_classes.append(i)
	
	$Sprite.modulate = player.national_color
	

func show_roads_to_others_provinces():
	for i in list_of_neighbors_tiles:
		var line = Line2D.new()
		line.add_point(position)
		line.add_point(i.position)
		line.visible = true
		get_parent().add_child(line)
		list_of_lines.append(line)


func hide_roads_to_others_provinces():
	for i in list_of_lines:
		i.queue_free()
	list_of_lines.clear()


func mouse_entered():
	show_roads_to_others_provinces()


func mouse_exited():
	hide_roads_to_others_provinces()


func division_entered_in_province(division):
	list_of_units.append(division)
	update_text_on_label()


func division_exited_in_province(division):
	list_of_units.erase(division)
	update_text_on_label()


func update_text_on_label():
	if player == Players.player:
		$Label.text = name_of_tile + "(" + str(list_of_units.size()) + ")"
	else:
		$Label.text = name_of_tile + "(?)"
	

func choose_units():
	Players.player.list_of_active_units.clear()
	Players.player.list_of_active_units.append_array(list_of_units)
	Players.player.window_list_of_units.show_units()


func get_bonus_of_production():
	return {
		production_of_factory = 0,
		production_of_mines   = 0,
		production_of_farms   = 0,
	}

func get_goods_in_province():
	goods_of_factories_in_province.clear()
	for i in resources:
		goods_of_factories_in_province.append(i)
