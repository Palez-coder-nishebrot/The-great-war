extends Node

const tipe = "factory"

const min_salary:        int          = 10
const time:              int          = 3
var money:               int          = 500
var max_employed_number: int          = 1
var employed_number:     int          = 0
var reserve:             float        = 0.0
var subsidization:       bool         = false
var closed:              bool         = false
var good:            String           = ""
var name_of_factory: String           = ""
var purchase:    Dictionary       = {}

var province:         Object
var object_of_worker: Object


func make_goods():
	province.player.local_market[good] += 1
	money += Functions.get_price_of_good_on_local_market(good)
	
	Functions.change_GDP(good, 1, province.player)
	
	check_reserve()


func check_reserve():
	if province.player.bonuses_in_production.has(good):
		reserve += province.player.bonuses_in_production[good]
		
		if reserve >= 100.0:
			reserve -= 100.0
			make_goods()


func buy_purchase():
	var local_market = province.player.local_market
	for resourse in purchase:
		var list = Functions.check_good_on_global_market(resourse, purchase[resourse])
		
		if Functions.check_good_on_local_market(resourse, purchase[resourse], local_market):
			Functions.buy_good_on_local_market(self, resourse, purchase[resourse], local_market, Functions.get_price_of_good_on_local_market(resourse))
			
			
		elif list is Dictionary:
			money -= Functions.buy_good_on_global_market(resourse, 
			purchase[resourse], list, province.player)
			
	check_bankrupt()

	
func check_bankrupt():
	if money <= 0:
		if subsidization == true:
			province.player.economy["Кроны"] -= (100 - money)
			money = 100
		else:
			bankrupt()


func bankrupt():
	object_of_worker.quanity_on_factories.erase(self)
	employed_number = 0
	closed = true
