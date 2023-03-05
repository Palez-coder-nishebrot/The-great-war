extends Node

class_name Factory


const quantity_of_based_goods: float  = 0.025
const time:              int          = 10
var time_of_construction:int          = 0

var good_production:     float        = 0.0
var money:               int          = 250
var income:              int          = 0
var expenses_workers:    int          = 0
var expenses_raw:        int          = 0
var expenses_factory_equipment: int   = 0
var real_max_employed_number:   int   = 10
var max_employed_number: int          = 10
var workers_quantity:    float        = 0.0

var subsidization:       bool         = false
var closed:              bool         = true
var in_construction:     bool         = false

var good:              Resource
var type_factory:      Resource
var name_of_factory:   String
var raw:               Array
var factory_equipment: Array

var province:         Object
var expansion:        Object


func buy_factory_equipment():
	var old_money = money
	for good_for_buy in factory_equipment:
		var quantity = quantity_of_based_goods * workers_quantity
		if province.player.local_market[good_for_buy] >= quantity:
			Functions.buy_good_on_local_market(self, good_for_buy, quantity, province.player.local_market)
		else:
			var q = province.player.local_market[good_for_buy]
			Functions.buy_good_on_local_market(self, good_for_buy, q, province.player.local_market)
			money -= Functions.buy_good_on_global_market(good_for_buy, quantity - q, province.player)
	expenses_factory_equipment = old_money - money


func get_good_quantity():
	var quanity = workers_quantity * get_effiency_production()
	
	return stepify(quanity, 0.01)


func get_effiency_production():
	var ec_bonuses = province.player.economic_bonuses
	var effiency = good.based_effiency_production + ec_bonuses.factories_efficiency_production
	effiency += ec_bonuses.factory_efficiency_production[type_factory] + ec_bonuses.goods_efficiency_production[good]
	effiency += province.get_production_bonuses()[0] + get_production_bonuses_from_province()
	
	return effiency


func get_production_bonuses_from_province():
	var bonus = 0.0
	for resourse in raw:
		if province.goods_production_in_province.has(resourse):
			bonus += 0.1
	return bonus
	

func get_profit():
	return income - get_expenses()


func get_expenses():
	return expenses_factory_equipment + expenses_raw + expenses_workers


func update_places_for_workers():
	if income - get_expenses() < 0: 
		if max_employed_number > 1 and subsidization == false:
			max_employed_number -= 1
	elif real_max_employed_number > max_employed_number:
		max_employed_number += 1


func open_factory():
	closed = false
	money = 170
	province.player.budget -= 170


func bankrupt():
	closed = true
	province.get_goods_in_province()


func start_build_factory():
	var game = province.player.game
	
	while time_of_construction != time:
		yield(game, "new_day")
		time_of_construction = time_of_construction + 1
		
	province.player.list_of_factories.append(self)
	
	game.factory_manager.list_of_factories.append(self)
	
	province.get_goods_in_province()
	
	in_construction = false
	
