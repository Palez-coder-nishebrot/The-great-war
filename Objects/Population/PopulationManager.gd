extends Node


var needs: Object = load("res://Objects/Population/NeedsOfPopulation/Needs.gd").new()

var money:  float = 0
var welfare:int = 0 # Благосостояние
var income: float = 0

var new_generation: float = 0.0
var growth_of_new_generation: float = 0.0
var quantity_of_unemployed: float = 0.0

var quantity_of_factory_workers: int = 0
var quantity_of_workers: int = 0
var quantity_of_clerks: int = 0

var education: float = 0

var province: Object
var player: Object


func get_quantity_of_population():
	return quantity_of_factory_workers + quantity_of_workers + quantity_of_clerks


func update_population_growth():
	var points = (get_quantity_of_population() + welfare + province.player.economic_bonuses.population_growth) * 0.01
	province.population_manager.new_generation            += points
	province.population_manager.growth_of_new_generation  += points
