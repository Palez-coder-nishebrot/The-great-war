extends Node2D

onready var game: Node2D = get_parent()

const circle = 16

#var list_of_tiles: Array = []
var list_of_tiles: Dictionary = {}

func create_map():
	var graph =                  (load("res://Objects/Global/Provinces.gd").new()).graph
	var provinces_of_countries = (load("res://Objects/Global/Provinces.gd").new()).provinces_of_countries
	var resourses              = (load("res://Objects/Global/Provinces.gd").new()).resourses
	append_tiles_in_list()
	
	
	for i in get_children():
		if i.get_class() == "Node2D":
			set_resourses_of_tiles(i, resourses)
			get_parent().list_of_privinces.append(i)
			if graph.has(i.name):
				for y in graph[i.name]:
					i.list_of_neighbors_tiles.append(list_of_tiles[y])
					list_of_tiles[y].list_of_neighbors_tiles.append(i)
					
	give_tiles_to_players(provinces_of_countries)
	
	get_parent().new_day()
	
#	find_object_of_player_in_areas()
#
#	var X = 265
#	var Y = 305
#	var part_of_X = X / 2
#	var pos = Vector2(0, 0)
#
#	for _i in range(8):
#		for _u in range(circle):
#			create_tile(pos, X)
#			pos.x += X
#
#		pos.y += Y / 1.35
#		pos.x = part_of_X
#
#		for _u in range(circle):
#			create_tile(pos, X)
#			pos.x += X
#
#		pos.y += Y / 1.35
#		pos.x = 0
#
#	yield(get_tree().create_timer(0.1), "timeout")
#	set_names_of_tiles()


#func create_tile(pos: Vector2, x: int):
#	var hex = load("res://Objects/Tile/tile.tscn").instance()
#	hex.position = pos
#	pos.x += x
#	list_of_tiles.append(hex)
#	get_parent().add_child(hex)
#
#
#func set_names_of_tiles():
#	var token: int = 0
#	var provinces = (load("res://Objects/Global/Provinces.gd").new()).names_of_provinces
#	var resourses = (load("res://Objects/Global/Provinces.gd").new()).resourses
#	var fatories  = (load("res://Objects/Global/Provinces.gd").new()).factories_on_start
#	var list = []
#	for i in list_of_tiles:
#		if i.player != null:
#			i.name_of_tile = provinces[token]
#			i.sprite.modulate = Players.list_of_players_on_start[i.player.name_of_country]["Цвет"]
#			i.label.text = i.name_of_tile
#			i.resources = resourses[i.name_of_tile].duplicate()
#			i.panel_resources.update_information()
#			set_factories_on_start_of_game(fatories, i)
#
#			i.player.list_of_soc_classes.append(i.household)
#
#			token = token + 1
#
#			list.append(i)
#
#		else:
#			i.queue_free()
#
#	get_parent().list_of_privinces = list.duplicate()
#	get_parent().new_day()
#
#
#func find_object_of_player_in_areas():
#	for i in get_children():
#		if i.get_class() == "Area2D":
#			i.find_object_of_player()


func set_resourses_of_tiles(province, resourses):
	province.resources = resourses[province.name_of_tile]


func give_tiles_to_players(provinces_of_countries):
	var factories  = (load("res://Objects/Global/Provinces.gd").new()).factories_on_start
	for player in Players.list_of_players:
		for y in provinces_of_countries[player.name_of_country]:
			player.list_of_tiles.append(list_of_tiles[y])
			player.list_of_soc_classes.append(list_of_tiles[y].household)
			list_of_tiles[y].player = player
			list_of_tiles[y].get_node("Sprite").modulate = player.national_color
			
			list_of_tiles[y].start()
			
			set_factories_on_start_of_game(factories, list_of_tiles[y])


func append_tiles_in_list():
	for i in get_children():
		if i.get_class() == "Node2D":
			list_of_tiles[i.name] = i
			i.name_of_tile = i.name


func set_information_of_province(province):
	province.name_of_tile = province.name
	
	
func set_factories_on_start_of_game(list, province):
	if list.has(province.name_of_tile):
		var dict = list[province.name_of_tile]
		for i in dict:
			create_factory(i, province)
	

func create_factory(good, province):
	var factory = load("res://Objects/Building/Factory.gd").new()
	factory.name_of_factory = Players.goods_to_factory[good]
	factory.good = good
	factory.purchase = GlobalMarket.goods[factory.good]
	factory.province = province
	province.list_of_buildings.append(factory)
	
