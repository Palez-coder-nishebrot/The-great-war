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

var list_of_households_with_education: Array = []

var province: Object
var player: Object
