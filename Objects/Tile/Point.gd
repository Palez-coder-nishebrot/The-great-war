extends Node2D

const max_of_buildings: int = 5

var list_of_lines:              Array      = []

var list_of_neighbors_tiles:    Array      = []
var list_of_buildings:          Array      = []
var list_of_military_factories: Array      = []
var list_of_units:              Array      = []
var list_of_villages:           Array      = []
var list_of_households:         Array      = []
var goods_of_factories_in_province: Array  = []

var name_of_tile:        String
var landscape:           String = "Степь"
var capital:             bool = false
var player:              Object
var training_units:      Object

var resources:              Dictionary = {}
var railways:               Object = load("res://Objects/Building/Railways.gd").new()
var infrastructure:         Object = load("res://Objects/Building/Infrastructure.gd").new()
var factory_association:    Object = load("res://Objects/Population/Factory_association.gd").new()
var population_manager: Object


func start():
	name_of_tile = name
	update_text_on_label()


func input(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			Players.player.window_province.update_information(self, "province")
		
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
	
	population_manager.player = player
	
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


func build_building(name_of_building):
	var factory = load("res://Objects/Building/Factory.gd").new()
	factory.name_of_factory = name_of_building
	factory.good = GlobalMarket.find_building_in_list(name_of_building)
	factory.purchase = GlobalMarket.goods[factory.good]
	factory.province = self
	
	var process = load("res://Objects/Building/Process.gd").new()
	process.building = factory
	process.game = get_parent().get_parent()
	process.start_build_factory(list_of_buildings)
	list_of_buildings.append(process)
	

func build_military_factory(name_of_building):
	var factory = load("res://Objects/Building/Military_factory.gd").new()
	factory.name_of_factory = name_of_building
	factory.province = self
	
	var process = load("res://Objects/Building/Process.gd").new()
	process.building = factory
	process.game = get_parent().get_parent()
	process.start_build_factory(list_of_military_factories)
	list_of_buildings.append(process)


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
	if Players.player.get_groups().has("Human"):
		Players.player.list_of_active_units.clear()
		Players.player.list_of_active_units.append_array(list_of_units)
		Players.player.window_list_of_units.show_units()


func get_bonus_of_production():
	var production_of_factory = 0.0
	var production_of_mines   = 0.0
	var production_of_farms   = 0.0
	match railways.level:
		1: 
			production_of_factory += 1.0
			production_of_mines   += 2.0
			production_of_farms   += 1.0
		2:
			production_of_factory += 2.0
			production_of_mines   += 4.0
			production_of_farms   += 3.0
		3:
			production_of_factory += 3.0
			production_of_mines   += 6.0
			production_of_farms   += 4.5
		4:
			production_of_factory += 4.0
			production_of_mines   += 8.0
			production_of_farms   += 6.0
		5:
			production_of_factory += 5.0
			production_of_mines   += 10.0
			production_of_farms   += 6.5
			
	match infrastructure.level:
		1: 
			production_of_factory += 2.0
			production_of_mines   += 4.0
			production_of_farms   += 3.0
		2:
			production_of_factory += 4.0
			production_of_mines   += 8.0
			production_of_farms   += 6.0
		3:
			production_of_factory += 6.0
			production_of_mines   += 15.0
			production_of_farms   += 8.0
		4:
			production_of_factory += 8.0
			production_of_mines   += 20.0
			production_of_farms   += 12.0
		5:
			production_of_factory += 10.0
			production_of_mines   += 25.0
			production_of_farms   += 15.0
			
	return {
		production_of_factory = production_of_factory,
		production_of_mines   = production_of_mines,
		production_of_farms   = production_of_farms,
	}


func get_goods_in_province():
	goods_of_factories_in_province.clear()
	for i in list_of_buildings:
		if i.tipe == "factory" and not goods_of_factories_in_province.has(i):
			goods_of_factories_in_province.append(i)
	
	for i in resources:
		if not goods_of_factories_in_province.has(i):
			goods_of_factories_in_province.append(i)
	
