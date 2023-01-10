extends Node2D

const factories: Dictionary = {
	"Steel_plant":             "res://Resources/Factories/TipesOfFactories/SteelPlant.tres",
	"Textile_factory":         "res://Resources/Factories/TipesOfFactories/TextileFactory.tres",
	"Glass_factory":           "res://Resources/Factories/TipesOfFactories/GlassFactory.tres",
	"Electrical_appliance_factory": "res://Resources/Factories/TipesOfFactories/ElectricalApplianceFactory.tres",
	"Electrical_parts_factory": "res://Resources/Factories/TipesOfFactories/ElectricalPartsFactory.tres",
	"Lumber_plant": "res://Resources/Factories/TipesOfFactories/LumberPlant.tres",
	"Cars_factory": "res://Resources/Factories/TipesOfFactories/CarsFactory.tres",
	"Telegraph_factory": "res://Resources/Factories/TipesOfFactories/TelegraphFactory.tres",
	"Phone_factory": "res://Resources/Factories/TipesOfFactories/PhoneFactory.tres",
	"Radio_factory": "res://Resources/Factories/TipesOfFactories/RadioFactory.tres",
	"Furniture_factory": "res://Resources/Factories/TipesOfFactories/FurnitureFactory.tres",
	"Distillery": "res://Resources/Factories/TipesOfFactories/Distillery.tres",
	"Clothes_factory": "res://Resources/Factories/TipesOfFactories/ClothesFactory.tres",
	"Canning_factory": "res://Resources/Factories/TipesOfFactories/CanningFactory.tres",
	"Gas_factory": "res://Resources/Factories/TipesOfFactories/GasFactory.tres",
	"Airplane_factory": "res://Resources/Factories/TipesOfFactories/AirplaneFactory.tres",
	
	"Rubber_factory": "res://Resources/Factories/TipesOfFactories/RubberFactory.tres",
	"Oil_factory": "res://Resources/Factories/TipesOfFactories/OilFactory.tres",
	"Senthetic_textile_factory": "res://Resources/Factories/TipesOfFactories/SentheticTextileFactory.tres",
}

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
	append_tiles_in_list()
	give_tiles_to_players()
	ProvinceLoader.create_map(list_of_tiles, get_parent())


func append_tiles_in_list():
	for i in get_children():
		if i.get_class() == "TextureButton" and i.name != "Map":
			list_of_tiles[i.name] = i
			i.name_of_tile = i.name
			list_of_provinces[i.name] = i


func give_tiles_to_players():
	var folder: Directory = Directory.new()
	var _err = folder.open("res://Resources/StatesOnStartGame/States/")
	var _err_ = folder.list_dir_begin(true, true)
	var folder_name = folder.get_next()

	while folder_name != "":
		var file = load("res://Resources/StatesOnStartGame/States/" + folder_name)
		var client = Players.find_client(file.name_of_state)

		for i in file.list_of_regions:
			var tile = list_of_tiles[i]
			tile.player = client
			tile.start()

		folder_name = folder.get_next()
