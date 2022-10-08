extends Sprite

class_name Region

const max_of_buildings: int = 5

var list_of_lines:              Array      = []

var list_of_neighbors_tiles:    Array      = []
var list_of_buildings:          Array      = []
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
#var administration:         Dictionary = {}
var railways:               Object = Railways.new()
var infrastructure:         Object = Infrastructure.new()
var population_manager:     Object

onready var name_of_region: Object = $Label
onready var polygon:  Object = $Area2D/CollisionPolygon2D


func _ready():
	var err_ = ManagerDay.connect("allocate_workers_to_factories", self, "allocate_workers_to_factories")


func start():
	player.list_of_tiles.append(self)
	change_color_of_region(player.national_color)
	name_of_tile = name
	update_text_on_label()


func input(viewport, event, shape_idx):
	
	if event is InputEventMouseButton and event.pressed:
		if event.button_index == BUTTON_LEFT:
			if not Players.player.get_groups().has("ProvEditor"):
				if Players.player.window_build_factory.choose_position_for_building == true:
					Players.player.window_build_factory.build_factory(self)
				
				elif Players.player.information.showing_map == 0 or Players.player.information.showing_map == 2:
					Players.player.window_province.update_information(self, "province")
					#print(population_manager.needs.list_of_needs[3].name_of_good)
				
				else:
					choose_units()
			else:
				Players.player.window_province.update_information(self, "province")
		
		elif event.button_index == BUTTON_RIGHT:
			if Players.player.get_groups().has("Human") and Players.player.information.showing_map == true:
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
	
	change_color_of_region(player.national_color)

func change_color_of_region(color):
	modulate = color
	

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


func build_building(name_of_building, cost):
	player.budget -= cost
	
	var factory = load("res://Objects/Building/Factory.gd").new()
	factory.name_of_factory = name_of_building
	factory.good = GlobalMarket.find_building_in_list(name_of_building)
	factory.purchase = GlobalMarket.goods[factory.good]
	factory.province = self
	factory.in_construction = true
	factory.start_build_factory()
	factory.province.workplaces += 1
	
	list_of_buildings.append(factory)
	

func build_military_factory(name_of_building, cost):
	player.budget -= cost
	
	var factory = load("res://Objects/Building/Military_factory.gd").new()
	factory.good = "Боеприпасы"
	factory.name_of_factory = name_of_building
	factory.province = self
	factory.in_construction = true
	factory.start_build_factory()
	factory.province.workplaces += 1
	
	list_of_buildings.append(factory)


func division_entered_in_province(division):
	list_of_units.append(division)
	update_text_on_label()
	show_units()

func division_exited_in_province(division):
	list_of_units.erase(division)
	update_text_on_label()
	show_units()


func update_text_on_label():
	if player == Players.player:
		name_of_region.text = name_of_tile + "(" + str(list_of_units.size()) + ")"
	else:
		name_of_region.text = name_of_tile + "(?)"
	

func choose_units():
	if Players.player.get_groups().has("Human"):
		Players.player.list_of_active_units.clear()
		Players.player.list_of_active_units.append_array(list_of_units)
		Players.player.window_list_of_units.show_units()


func set_default_region():
	change_color_of_region(player.national_color)
	name_of_region.text = name_of_tile


func show_resources():
	var good = Players.player.information.showing_good
	if resources.has(good):
		change_color_of_region(Color(0.321569, 0.670588, 0.184314))
	else:
		change_color_of_region(Color(0.350586, 0.350586, 0.350586))


func show_name_of_region():
	name_of_region.text = name_of_tile


func show_units():
	if list_of_units.size() == 0:
		name_of_region.text = "Пусто"
	else:
		name_of_region.text = "Дивизии(" + str(list_of_units.size()) + ")"


func get_bonus_of_production():
	var production_of_factory = 0.0
	var production_of_mines   = 0.0
	var production_of_farms   = 0.0
	match railways.level:
		1: 
			production_of_factory += 0.1
			production_of_mines   += 0.2
			production_of_farms   += 0.1
		2:
			production_of_factory += 0.2
			production_of_mines   += 0.4
			production_of_farms   += 0.3
		3:
			production_of_factory += 0.3
			production_of_mines   += 0.6
			production_of_farms   += 4.5
		4:
			production_of_factory += 0.4
			production_of_mines   += 0.8
			production_of_farms   += 0.6
		5:
			production_of_factory += 5.0
			production_of_mines   += 1.0
			production_of_farms   += 0.6
			
	match infrastructure.level:
		1: 
			production_of_factory += 0.2
			production_of_mines   += 0.4
			production_of_farms   += 0.3
		2:
			production_of_factory += 0.4
			production_of_mines   += 0.8
			production_of_farms   += 0.6
		3:
			production_of_factory += 0.6
			production_of_mines   += 0.1
			production_of_farms   += 0.8
		4:
			production_of_factory += 0.8
			production_of_mines   += 2.0
			production_of_farms   += 1.0
		5:
			production_of_factory += 1.0
			production_of_mines   += 0.2
			production_of_farms   += 0.1
			
	return {
		production_of_factory = production_of_factory,
		production_of_mines   = production_of_mines,
		production_of_farms   = production_of_farms,
	}


func get_goods_in_province():
	goods_of_factories_in_province.clear()
	for i in list_of_buildings:
		if i.tipe != "process":
			goods_of_factories_in_province.append(i.good)
	
	var res = resources.duplicate().keys()
	for i in list_of_villages:
		res.append_array(i.resources.keys())
		
	for i in res:
		if not goods_of_factories_in_province.has(i):
			goods_of_factories_in_province.append(i)


func get_factories_in_province():
	var list = []
	for i in list_of_buildings:
		list.append(i.name_of_factory)
	return list


func allocate_workers_to_factories():
	if list_of_buildings.size() != 0:
		var reserve_of_workers = 0.0 
		var workers = stepify(float(population_manager.list_of_factory_workers.size()) / list_of_buildings.size(), 0.01) #0.66
		for factory in list_of_buildings:
			if factory.max_employed_number < workers:
				reserve_of_workers += workers - factory.max_employed_number
				factory.quantity_of_workers = factory.max_employed_number
			
			elif factory.max_employed_number > workers and reserve_of_workers > 0.0:
				factory.quantity_of_workers = workers
				var free_workplaces = factory.max_employed_number - factory.quantity_of_workers
				reserve_of_workers -= free_workplaces
				factory.quantity_of_workers += free_workplaces
			
			else:
				factory.quantity_of_workers = workers
		reserve_of_workers = check_first_factory(list_of_buildings[0], reserve_of_workers)
		population_manager.quantity_of_unemployed = reserve_of_workers
		
	else:
		population_manager.quantity_of_unemployed = population_manager.list_of_factory_workers.size()


func check_first_factory(factory, reserve_of_workers):
	var free_workplaces = factory.max_employed_number - factory.quantity_of_workers
	
	if reserve_of_workers > free_workplaces:
		reserve_of_workers -= free_workplaces
		factory.quantity_of_workers += free_workplaces
	else:
		factory.quantity_of_workers += reserve_of_workers
		reserve_of_workers = 0
	
	return reserve_of_workers

#func get_quantity_of_unemployed():
#	if workplaces < population_manager.list_of_factory_workers.size():
#		var quantity_of_unemployed = population_manager.list_of_factory_workers.size() - workplaces
#		population_manager.quantity_of_unemployed = quantity_of_unemployed
#		player.quantity_of_unemployed += quantity_of_unemployed
#
#	elif workplaces == population_manager.list_of_factory_workers.size():
#		population_manager.quantity_of_unemployed = 0
#
#	elif workplaces > population_manager.list_of_factory_workers.size():
#		population_manager.quantity_of_unemployed = 0
#		free_workplaces = (workplaces - list_of_buildings.size()) - population_manager.list_of_factory_workers.size()
#		#breakpoint
#
#	# get_workers_for_additional_jobs()
#	var additional_jobs = workplaces - list_of_buildings.size()
#	population_manager.workers_for_additional_jobs = additional_jobs
#	# get_workers_for_additional_jobs()


func set_collision_from_sprite(collisions):
	var new_polygon
	if collisions.list_of_pol_of_provinces.has(name_of_tile):
		new_polygon = collisions.list_of_pol_of_provinces[name_of_tile]
	
	else:
		new_polygon = Functions.convert_sprite_to_collision(texture)
		var file = ResourceLoader.load("res://Objects/Provinces/CollisionPolygons_of_provinces.tres")
		file.list_of_pol_of_provinces[name_of_tile] = new_polygon
		ResourceSaver.save("res://Objects/Provinces/CollisionPolygons_of_provinces.tres", file)
	
	polygon.set_polygon(new_polygon)
		
	polygon.position.x -= get_rect().size.x / 2
	polygon.position.y -= get_rect().size.y / 2
