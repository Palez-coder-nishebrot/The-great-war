extends Node


class_name ProductionEfficiencyManager

var prod_fact_efficiency_from_reforms: float = 0.0
var production_factories_efficiency:   float = 0.0
var production_dp_efficiency:          float = 0.0

var production_goods_efficiency: Dictionary = {
	load("res://Resources/Good/alcohol.tres"):     0.0,
	load("res://Resources/Good/ammo.tres"):        0.0,
	load("res://Resources/Good/artillery.tres"):   0.0,
	load("res://Resources/Good/beasts.tres"):      0.0,
	load("res://Resources/Good/canned_food.tres"): 0.0,
	load("res://Resources/Good/cars.tres"):        0.0,
	load("res://Resources/Good/clothes.tres"):     0.0,
	load("res://Resources/Good/coal.tres"):        0.0,
	load("res://Resources/Good/cotton.tres"):      0.0,
	load("res://Resources/Good/el_parts.tres"):    0.0,
	load("res://Resources/Good/furniture.tres"):   0.0,
	load("res://Resources/Good/gas.tres"):         0.0,
	load("res://Resources/Good/glass.tres"):       0.0,
	load("res://Resources/Good/grain.tres"):       0.0,
	load("res://Resources/Good/iron.tres"):        0.0,
	load("res://Resources/Good/lumber.tres"):      0.0,
	load("res://Resources/Good/mech_parts.tres"):  0.0,
	load("res://Resources/Good/oil.tres"):         0.0,
	load("res://Resources/Good/phone.tres"):       0.0,
	load("res://Resources/Good/radio.tres"):       0.0,
	load("res://Resources/Good/rifles.tres"):      0.0,
	load("res://Resources/Good/rubber.tres"):      0.0,
	load("res://Resources/Good/saltpeter.tres"):   0.0,
	load("res://Resources/Good/steel.tres"):       0.0,
	load("res://Resources/Good/tanks.tres"):       0.0,
	load("res://Resources/Good/textile.tres"):     0.0,
	load("res://Resources/Good/wood.tres"):        0.0,
}


func get_production_factories_efficiency():
	return production_factories_efficiency + prod_fact_efficiency_from_reforms
