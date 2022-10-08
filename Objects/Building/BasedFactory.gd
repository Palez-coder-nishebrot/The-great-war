extends Node

class_name Factory

const time:              int          = 10
var time_of_construction:int          = 0

var output:              float        = 0.0
var money:               int          = 250
var income:              int          = 0
var expenses_workers:    int          = 0
var expenses_purchase:   int          = 0
var max_employed_number: int          = 1
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


func get_quantity_of_workers():
#	quantity_of_workers = 0
#	quantity_of_workers = province.population_manager.list_of_factory_workers.size() / province.list_of_buildings.size()
#	quantity_of_workers = stepify(quantity_of_workers, 0.1)
	return quantity_of_workers
#	if province.population_manager.list_of_factory_workers.size() > 0:
#		quantity_of_workers += province.population_manager.list_of_factory_workers.size() - province.population_manager.quantity_of_unemployed
#		quantity_of_workers = float(quantity_of_workers) / float(province.workplaces - province.free_workplaces)
#		quantity_of_workers = stepify(quantity_of_workers, 0.1)
#
#		if max_employed_number - quantity_of_workers >= province.population_manager.workers_for_additional_jobs:
#			var workers = province.population_manager.workers_for_additional_jobs
#			quantity_of_workers += workers
#			province.population_manager.workers_for_additional_jobs -= workers
#	return quantity_of_workers


func get_quanity_of_good():
	var quanity = get_quantity_of_workers() * get_bonuses_for_production_from_province() * get_bonuses_for_production_for_factories()
	quanity = quanity * get_bonuses_for_production_from_capitalists()
	
	return quanity


func get_bonuses_for_production_for_factories():
	return province.player.economic_bonuses.production_of_factories


func get_bonuses_for_production_from_province():
	var bonus = 1.0
	for resourse in purchase:
		if province.goods_of_factories_in_province.has(resourse):
			bonus = bonus + 0.1
	return bonus


func get_bonuses_for_production_from_capitalists():
	return 1


func get_bonuses_for_production_of_factory():
	return province.player.economic_bonuses.production_of_factories


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
	
