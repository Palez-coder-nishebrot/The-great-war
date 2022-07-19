extends Node2D

onready var game: Node2D = get_parent()

#var list_of_tiles: Array = []
var list_of_tiles: Dictionary    = {}

var list_of_provinces: Dictionary ={}
var list_of_villages: Dictionary = {}

var resourses_of_province  = (load("res://Objects/Global/Provinces.gd").new()).resourses_of_provinces
var resourses_of_villages  = (load("res://Objects/Global/Provinces.gd").new()).resourses_of_villages
var provinces_of_countries = (load("res://Objects/Global/Provinces.gd").new()).provinces_of_countries

var exper: Array = []

func Start():
	for i in range(200):
		resourses_of_villages[str(i)] = ["-Хлеб"]
		resourses_of_province["Лодзь"].append("+" + str(i))
		var prov = get_node("Трускавец").duplicate()
		prov.name = str(i)
		add_child(prov)


func create_map():
	
	#Start()
	
	append_tiles_in_list()
	
	set_paths()
	
	for i in list_of_tiles:
		if list_of_provinces.has(i):
			set_resourses_of_tiles(list_of_tiles[i], resourses_of_province)
			get_parent().list_of_privinces.append(list_of_tiles[i])
		else:
			set_resourses_of_tiles(list_of_tiles[i], resourses_of_villages)
			
	for i in list_of_provinces:
		for y in list_of_provinces[i].list_of_villages:
			set_graph(y, i)
			
	give_tiles_to_players()
	

func set_paths():
	var graph = (load("res://Objects/Global/Provinces.gd").new()).graph
	
	for i in list_of_tiles:
		if graph.has(i):
			for y in graph[i]:
				set_graph(list_of_tiles[i], y)


func set_graph(tile, tile_point):
	tile.list_of_neighbors_tiles.append(list_of_tiles[tile_point])
	list_of_tiles[tile_point].list_of_neighbors_tiles.append(tile)

	
func set_resourses_of_tiles(province, resourses):
	for i in resourses[province.name_of_tile]:
		if i[0] == "+":
			i.erase(0, 1)
			province.list_of_villages.append(list_of_villages[i])
		
		elif GlobalMarket.list_of_resourses.has(i):
			province.resources[i] = 1
		
		elif i[0] == "-":
			i.erase(0, 1)
			province.resources[i] = 1
		
		elif i[0] == "2" or i[0] == "3":
			var num = int(i[0])
			i.erase(0, 1)
			create_factory(i, province, num)
		
		else:
			create_factory(i, province, 1)
			

func give_tiles_to_players():
	
	for player in Players.list_of_players:
		for y in provinces_of_countries[player.name_of_country]:
			
			var tile = list_of_tiles[y]
				
			give_to_tiles(player, tile, 4)
			player.list_of_tiles.append(tile)
			
			for i in tile.list_of_villages:
				give_to_tiles(player, i, 8)
	get_parent().new_day()


func give_to_tiles(player, tile, pop):
	var population_manager = load("res://Objects/Population/PopulationManager.gd").new()
	tile.population_manager = population_manager
	get_parent().purchase_manager.list_of_population_managers.append(population_manager)
	
	for i in range(pop):
		var household = {
			factory  =  null,
			province = null,
			tipe     = "",
			population_manager = tile.population_manager,
		}
		population_manager.list_of_soc_classes.append(household)
		population_manager.list_of_not_working_population.append(household)
		population_manager.player   = player
		population_manager.province = tile
		get_parent().purchase_manager.check_province(population_manager, tile)
		
		household.province = tile
		get_parent().purchase_manager.check_province(household, tile)
		get_parent().list_of_soc_classes.append(household)
		tile.list_of_households.append(household)
		player.list_of_soc_classes.append(household)
	
#	tile.household.province = tile
#	tile.household.check_province()
#	tile.household.quanity = pop
	tile.player = player
	tile.get_node("Sprite").modulate = player.national_color
	tile.start()


func append_tiles_in_list():
	for i in get_children():
		if i.get_class() == "Node2D":
			list_of_tiles[i.name] = i
			i.name_of_tile = i.name
			
			if i.get_groups().has("Village"):
				list_of_villages[i.name] = i
			else:
				list_of_provinces[i.name] = i
			
			
func set_information_of_province(province):
	province.name_of_tile = province.name
	

func create_factory(good, province, level):
	var factory = load("res://Objects/Building/Factory.gd").new()
	factory.name_of_factory = Players.goods_to_factory[good]
	factory.good = good
	factory.purchase = GlobalMarket.goods[factory.good]
	factory.province = province
	factory.max_employed_number = level
	#factory.object_of_worker = province.household
	province.list_of_buildings.append(factory)
	
	get_parent().factory_manager.list_of_factories.append(factory)
