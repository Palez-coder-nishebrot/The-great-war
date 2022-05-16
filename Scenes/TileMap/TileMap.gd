extends Node2D

onready var game: Node2D = get_parent()

const circle = 16

var list_of_tiles: Array = []

func create_map():
	
	find_object_of_player_in_areas()
	
	var X = 265
	var Y = 305
	var part_of_X = X / 2
	var pos = Vector2(0, 0)
	
	for _i in range(8):
		for _u in range(circle):
			create_tile(pos, X)
			pos.x += X
			
		pos.y += Y / 1.35
		pos.x = part_of_X
		
		for _u in range(circle):
			create_tile(pos, X)
			pos.x += X
			
		pos.y += Y / 1.35
		pos.x = 0
		
	yield(get_tree().create_timer(0.1), "timeout")
	set_names_of_tiles()


func create_tile(pos: Vector2, x: int):
	var hex = load("res://Objects/Tile/tile.tscn").instance()
	hex.position = pos
	pos.x += x
	list_of_tiles.append(hex)
	get_parent().add_child(hex)


func set_names_of_tiles():
	var token: int = 0
	var provinces = (load("res://Objects/Global/Provinces.gd").new()).names_of_provinces
	var resourses = (load("res://Objects/Global/Provinces.gd").new()).resourses
	var fatories  = (load("res://Objects/Global/Provinces.gd").new()).factories_on_start
	var list = []
	for i in list_of_tiles:
		if i.player != null:
			i.name_of_tile = provinces[token]
			i.sprite.modulate = Players.list_of_players_on_start[i.player.name_of_country]["Цвет"]
			i.label.text = i.name_of_tile
			i.resources = resourses[i.name_of_tile].duplicate()
			set_factories_on_start_of_game(fatories, i)
			
			i.player.list_of_soc_classes.append(i.household)
			
			token = token + 1
			
			list.append(i)
			
		else:
			i.queue_free()
	
	get_parent().list_of_privinces = list.duplicate()
	get_parent().new_day()


func find_object_of_player_in_areas():
	for i in get_children():
		if i.get_class() == "Area2D":
			i.find_object_of_player()


func set_factories_on_start_of_game(list, province):
	if list.has(province.name_of_tile):
		var dict = list[province.name_of_tile]
		for i in dict:
			create_factory(i, province, dict[i])
	

func create_factory(good, province, quanity_of_workshops):
	var factory = load("res://Objects/Building/Factory.gd").new()
	factory.name_of_factory = Players.goods_to_factory[good]
	factory.good = good
	factory.purchase = GlobalMarket.goods[factory.good]
	factory.province = province
	factory.max_employed_number = quanity_of_workshops
	province.list_of_buildings.append(factory)
	
