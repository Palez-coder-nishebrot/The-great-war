extends Node2D

onready var game: Node2D = get_parent()



#var list_of_tiles: Array = []
var list_of_tiles: Dictionary    = {}

var list_of_provinces: Dictionary ={}
var list_of_villages: Dictionary = {}

var paths_of_province
var resourses_of_province
var factories_of_province
var villages_of_province
var households_of_province
var provinces_of_countries = (load("res://Objects/Global/Provinces.gd").new()).provinces_of_countries

var exper: Array = []


func create_map():
	var file = ResourceLoader.load("res://Objects/Provinces/Paths_of_provinces.tres")
	
	resourses_of_province  = file.list_of_resources_of_provinces
	factories_of_province  = file.list_of_factories_of_provinces
	villages_of_province   = file.list_of_villages_of_provinces
	households_of_province = file.list_of_household_of_provinces
	paths_of_province      = file.list_of_path_of_provinces
	
	append_tiles_in_list()
	
	set_collision_of_provinces()
	for i in list_of_tiles:
		set_resourses_of_tiles(list_of_tiles[i], resourses_of_province[i])
		set_paths(list_of_tiles[i])
	
	for i in list_of_tiles:
		list_of_tiles[i].population_manager = load("res://Objects/Population/PopulationManager.gd").new()
		list_of_tiles[i].population_manager.province = list_of_tiles[i]
		set_households_of_provinces(list_of_tiles[i], households_of_province[i])
		if factories_of_province.has(i):
			set_factories_of_tiles(list_of_tiles[i], factories_of_province[i])
		
		get_parent().list_of_provinces.append(list_of_tiles[i])
	
	give_tiles_to_players()


func set_collision_of_provinces():
	var collisions = ResourceLoader.load("res://Objects/Provinces/CollisionPolygons_of_provinces.tres")
	for i in list_of_tiles:
		list_of_tiles[i].set_collision_from_sprite(collisions)

func set_paths(tile):
	if paths_of_province.has(tile.name_of_tile):
		for i in paths_of_province[tile.name_of_tile]:
			set_graph(tile, i)


func set_graph(tile, tile_point):
	tile.list_of_neighbors_tiles.append(list_of_tiles[tile_point])
	list_of_tiles[tile_point].list_of_neighbors_tiles.append(tile)
	

func set_villages_of_tiles(tile):
	for i in villages_of_province[tile.name_of_tile]:
		tile.list_of_villages.append(list_of_tiles[i])
		list_of_tiles[i].get_goods_in_province()
	tile.get_goods_in_province()
		
	
func set_resourses_of_tiles(province, resources):
	for i in resources:
		province.resources[i] = 1
		province.goods_of_factories_in_province.append(i)
	

func set_factories_of_tiles(province, goods):
	for i in goods:
		if i == "Боеприпасы":
			create_military_factory(i, province)
		else:
			create_factory(i, province, 1)
	#province.get_goods_in_province()
	

func set_households_of_provinces(province, households):
	for i in households:
		var household = Household.new()
		household.province = province
		household.education = i.education
		household.soc_class = i.soc_class
		household.religion = ""
		household.population_manager = province.population_manager
		
		province.list_of_households.append(household)
		province.population_manager.list_of_soc_classes.append(household)
		
		if i.soc_class == "Рабочий":
			province.population_manager.list_of_workers.append(household)
		elif i.soc_class == "Фабричный рабочий":
			province.population_manager.list_of_factory_workers.append(household)
		else:
			province.population_manager.list_of_craftsmen.append(household)
			
		if household.education == true:
			province.population_manager.list_of_households_with_education.append(household)
		
		get_parent().purchase_manager.list_of_population_managers.append(province.population_manager)
		get_parent().list_of_soc_classes.append(household)
	
	set_needs_of_pop_manager(province.population_manager)
	

func set_needs_of_pop_manager(population_manager):
	population_manager.needs.set_objects_of_goods()
	population_manager.needs.set_needs(population_manager.list_of_soc_classes)


func give_tiles_to_players():
	var folder: Directory = Directory.new()
	folder.open("res://Resources/StatesOnStartGame/States/")
	folder.list_dir_begin(true, true)
	var folder_name = folder.get_next()
	
	while folder_name != "":
		var file = load("res://Resources/StatesOnStartGame/States/" + folder_name)
		var client = Players.find_client(file.name_of_state)
		
		for i in file.list_of_regions:
			var tile = list_of_tiles[i]
			tile.population_manager.player = client
			tile.player = client
			tile.start()
			
			for household in tile.population_manager.list_of_soc_classes:
				client.list_of_soc_classes.append(household)
				
				if household.soc_class == "Ремесленник":
					client.list_of_craftsmen.append(household)
			
			for factory in tile.list_of_buildings:
				client.list_of_factories.append(factory)
		folder_name = folder.get_next()
	get_parent().new_day()


func give_to_tiles(player, tile):
	tile.player = player
	tile.population_manager.player = player
	tile.modulate = player.national_color
	tile.start()
	player.list_of_tiles.append(tile)


func append_tiles_in_list():
	for i in get_children():
		if i.get_class() == "Sprite" and i.name != "Map":
			list_of_tiles[i.name] = i
			i.name_of_tile = i.name
			list_of_provinces[i.name] = i
		

func create_factory(good, province, level):
	var factory = load("res://Objects/Building/Factory.gd").new()
	factory.name_of_factory = Players.goods_to_factory[good]
	factory.good = good
	factory.purchase = GlobalMarket.goods[factory.good]
	factory.province = province
	factory.money = 250
	factory.max_employed_number = level
	province.list_of_buildings.append(factory)
	province.goods_of_factories_in_province.append(good)
	
	get_parent().factory_manager.list_of_factories.append(factory)
	province.goods_of_factories_in_province.append(good)


func create_military_factory(good, province):
	var factory = load("res://Objects/Building/Military_factory.gd").new()
	factory.good = good
	factory.purchase = GlobalMarket.goods[factory.good]
	factory.province = province
	factory.max_employed_number = 1
	province.list_of_buildings.append(factory)
	
	get_parent().factory_manager.list_of_factories.append(factory)
	province.goods_of_factories_in_province.append(good)


#func build_collision_from_sprite(province, file_to_save):
#	var texture = province.texture
#	var data = texture.get_data()
#
#	var bitmap = BitMap.new()
#	bitmap.create_from_image_alpha(data)
#	var polys = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, texture.get_size()), 5.0)
#
#	for poly in polys:
#
#		file_to_save.list_of_pol_of_provinces[province.name_of_tile] = poly
