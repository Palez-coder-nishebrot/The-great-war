extends Node

class_name Factory

var list_of_mechanisms: Array = [
	"mech_parts",
	"el_parts",
]

const time:              int          = 10
var time_of_construction:int          = 0

var output:              float        = 0.0
var money:               int          = 250
var income:              int          = 0
var expenses_workers:    int          = 0
var expenses_purchase:   int          = 0
var expenses_mechanisms: int          = 0
var real_max_employed_number: int     = 10
var max_employed_number: float        = 10
var reserve:             int          = 0
var quantity_of_workers: float        = 0.0

var subsidization:       bool         = false
var closed:              bool         = false
var in_construction:     bool         = false

var good:            String           = ""
var name_of_factory: String           = ""
var purchase:    Dictionary           = {}

var province:         Object
var expansion:        Object


func buy_based_goods():
	var old_money = money
	for good_for_buy in list_of_mechanisms:
		var quantity = 0.025 * quantity_of_workers
		if province.player.local_market[good_for_buy] >= quantity:
			Functions.buy_good_on_local_market(self, good_for_buy, quantity, province.player.local_market)
		else:
			var q = province.player.local_market[good_for_buy]
			Functions.buy_good_on_local_market(self, good_for_buy, q, province.player.local_market)
			money -= Functions.buy_good_on_global_market(good_for_buy, quantity - q, province.player)
	expenses_mechanisms = old_money - money


func get_quantity_of_workers():
	return quantity_of_workers


func get_quanity_of_good():
	var quanity = province.player.economic_bonuses.get("based_production_of_" + good) * province.get_bonus_of_production().production_of_factory
	quanity = quanity * get_quantity_of_workers() * get_bonuses_for_production_from_province() * get_bonuses_for_production_for_factories()
	quanity = quanity * get_bonuses_for_production_from_capitalists()
	
	return stepify(quanity, 0.01)


func get_bonuses_for_production_for_factories():
	return province.player.economic_bonuses.production_of_factories


func get_bonuses_for_production_from_province():
	var bonus = 1.0
	for resourse in purchase:
		if province.production_of_goods_in_province.has(resourse):
			bonus += 0.25
	return bonus


func get_bonuses_for_production_from_capitalists():
	return 1


func get_bonuses_for_production_of_factory():
	return province.player.economic_bonuses.production_of_factories


func get_expenses():
	return expenses_mechanisms + expenses_purchase + expenses_workers


func update_places_for_workers():
	if income - get_expenses() < 0: 
		if max_employed_number > 1:
			max_employed_number -= 0.5
	elif real_max_employed_number > max_employed_number:
		max_employed_number += 0.5


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
		
	if good != "Боеприпасы":
		province.player.list_of_factories.append(self)
	
	game.factory_manager.list_of_factories.append(self)
	
	province.get_goods_in_province()
	
	in_construction = false
	
