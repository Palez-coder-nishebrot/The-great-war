extends StaticBody2D

const max_of_buildings: int = 5

var list_of_neighbors_tiles:    Array      = []
var list_of_buildings:          Array      = []
var list_of_military_factories: Array      = []
var units:                      Array      = []

var name_of_tile: String
var capital: bool = false
var player: Object

var resources: Dictionary = {}
var railways:            Object = load("res://Objects/Building/Railways.gd").new()
var infrastructure:      Object = load("res://Objects/Building/Infrastructure.gd").new()
var household:           Object = load("res://Objects/Population/Household.gd").new()
var factory_association: Object = load("res://Objects/Population/Factory_association.gd").new()

onready var label:  Label          = $Label
onready var sprite: Sprite         = $Sprite
onready var panel_resources: Panel = $Panel_resources

func _ready():
	household.province = self

func input(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			Players.player.window_province.update_information(self)
			#print(household.lack, " Деньги: ", household.money)#'"', name_of_tile, '"', ": ", '"Сталь"', ",")


func build_building(name_of_building):
	var factory = load("res://Objects/Building/Factory.gd").new()
	factory.name_of_factory = name_of_building
	factory.good = GlobalMarket.find_building_in_list(name_of_building)
	factory.purchase = GlobalMarket.goods[factory.good]
	factory.province = self
	
	var process = load("res://Objects/Building/Process.gd").new()
	process.building = factory
	process.game = get_parent()
	process.start_build_factory(list_of_buildings)
	list_of_buildings.append(process)
	

func build_military_factory(name_of_building):
	var factory = load("res://Objects/Building/Military_factory.gd").new()
	factory.name_of_factory = name_of_building
	factory.province = self
	
	var process = load("res://Objects/Building/Process.gd").new()
	process.building = factory
	process.game = get_parent()
	process.start_build_factory(list_of_military_factories)
	list_of_buildings.append(process)


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


func show_resourses():
	panel_resources.visible = true
	label.text = ""
#	for i in resources:
#		label.text += i + ": " + str(resources[i]) + "\n"


func hide_resourses():
	panel_resources.visible = false
	label.text = name_of_tile
