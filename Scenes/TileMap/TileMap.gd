extends Node2D

@onready var game: Node2D = get_parent()

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


func create_map():
	append_tiles_in_list()
	SceneStorage.regions_manager.province_loader.create_map(list_of_tiles, get_parent())
	give_tiles_to_players()


func append_tiles_in_list():
	for i in get_children():
		if i.get_class() == "TextureButton" and i.name != "Map":
			list_of_tiles[i.name] = i
			i.name_of_tile = i.name
			list_of_provinces[i.name] = i


func give_tiles_to_players():
	var folder = DirAccess.open("res://Resources/StatesOnStartGame/States/")
	var _err_ = folder.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	var folder_name = folder.get_next()

	while folder_name != "":
		var file = load("res://Resources/StatesOnStartGame/States/" + folder_name)
		var client = Players.find_client(file.name_of_state)

		for i in file.list_of_regions:
			var tile = list_of_tiles[i]
			tile.player = client
			tile.set_new_owner(client)
			tile.start()

		folder_name = folder.get_next()
	print("give_tiles_to_players finished")
