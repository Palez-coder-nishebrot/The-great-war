extends Node


var needs: Object = load("res://Objects/Population/NeedsOfPopulation/Needs.gd").new()

var money:  float = 0
var welfare:int = 0 # Благосостояние
var income: float = 0
var new_generation: int = 0
var growth_of_new_generation: int = 0

var quantity_of_unemployed: float = 0.0
var list_of_soc_classes: Array = []

var list_of_factory_workers: Array = []
var list_of_workers: Array         = []
var list_of_craftsmen: Array       = []
var list_of_clerks: Array          = []

var quantity_of_factory_workers: int = 0
var quantity_of_workers: int = 0
var quantity_of_clerks: int = 0

var education: int = 0

var province: Object
var player: Object


func get_quantity_of_population():
	return quantity_of_factory_workers + quantity_of_workers + quantity_of_clerks
