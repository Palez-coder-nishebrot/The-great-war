extends Node

class_name EconomicBonuses

var population_growth:   int = 0
var attraction_migrants: int = 0
var max_railways:        int = 1
var max_infrastructure:  int = 1

var production_of_factories: float = 1.0
var production_of_farms:     float = 1.3
var production_of_mines:     float = 1.0
var production_of_military_factories: float = 1.0

var based_production_of_iron      = 0.8
var based_production_of_coal      = 1.0
var based_production_of_saltpeter = 1.0
var based_production_of_wood      = 0.5
var based_production_of_cotton    = 0.2
var based_production_of_beasts    = 1.0
var based_production_of_grain     = 1.0
var based_production_of_rubber    = 1.0
var based_production_of_oil       = 1.0

var based_production_of_steel         = 0.5
var based_production_of_glass         = 0.8
var based_production_of_textile       = 0.8
var based_production_of_el_parts      = 1.0
var based_production_of_mech_parts    = 1.0
var based_production_of_lumber        = 1.0

var based_production_of_el_appliances = 0.8
var based_production_of_gas           = 8.0
var based_production_of_cars          = 0.2
var based_production_of_telegraphs    = 0.5
var based_production_of_phone         = 0.5
var based_production_of_radio         = 0.5
var based_production_of_furniture     = 1.0
var based_production_of_alcohol       = 1.2
var based_production_of_clothes       = 1.0
var based_production_of_canned_food   = 1.0

var based_production_of_ammo          = 1.0
var based_production_of_artillery     = 0.5
var based_production_of_plane         = 0.5
var based_production_of_rifles        = 1.0
var based_production_of_tanks         = 0.1

var factory_efficiency_oil    = 0.8
var factory_efficiency_rubber = 0.5


var goods_from_technologies: Dictionary = {
	"iron": 1.0, 
	"coal": 1.0, 
	
	"saltpeter": 1.0,
	"wood":      1.0,
	"cotton": 1.0,
	"tabaco": 1.0,
	"tea":    1.0,
	
	"beasts": 1.0,
	"grain": 1.0,
	"rubber": 1.0,
	"oil": 1.0, 
	"steel": 1.0, 
	"glass": 1.0, 
	"gas": 1.0, 
	"electronics": 1.0,
}

var list_of_buildings: Array = [
	"Steel_plant",
	"Textile_factory",
	"Glass_factory",
	"Electrical_appliance_factory",
	"Electrical_parts_factory",
	"Lumber_plant",
	"Cars_factory",
	"Telegraph_factory",
	"Phone_factory",
	"Radio_factory",
	"Furniture_factory",
	"Distillery",
	"Clothes_factory",
	"Canning_factory",
]

const cost_of_factory: Dictionary = {
		"money":    150,
		"steel":    2,
		"el_parts": 1,
		"lumber":   1,
	}


func set_list_of_buildings():
	var list = []
	var folder: Directory = Directory.new()
	folder.open("res://Resources/Factories/TipesOfFactories/")
	folder.list_dir_begin(true, true)
	
	for i in range(17):
		var factory = Factory.new()
		var path_of_file = "res://Resources/Factories/TipesOfFactories/" + folder.get_next()
		var file = load(path_of_file)
		
		if list_of_buildings.has(file.name_of_factory):
			factory.name_of_factory = file.name_of_factory
			factory.good = file.good
			
			for y in file.raw:
				factory.purchase[y.good] = y.quantity
			list.append(factory)
	list_of_buildings = list


func find_factory(name_of_factory):
	for i in list_of_buildings:
		if i.name_of_factory == name_of_factory:
			return i
