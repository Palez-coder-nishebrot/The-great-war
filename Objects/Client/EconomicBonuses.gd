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

var based_production_of_iron      = 1.1
var based_production_of_coal      = 0.8
var based_production_of_saltpeter = 0.8
var based_production_of_wood      = 0.8
var based_production_of_cotton    = 0.9
var based_production_of_tabaco    = 0.8
var based_production_of_tea       = 0.8
var based_production_of_beasts    = 0.7
var based_production_of_grain     = 0.8
var based_production_of_rubber    = 0.8
var based_production_of_oil       = 0.8

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
