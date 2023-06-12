extends Node

class_name Enterprise

#export(Array) var required_product
#export(Array) var worker_limitation
#export(float) var worker_productivity = 1
#export(Resource) var product
#export(int) var money = 0


var good: Resource
var production_efficiency:      float = 0.0
var good_production_efficiency: float = 0.0
var income:                     float = 0.0
var expenses_workers:           float = 0.0
var wage:                       float = 0.0
var money:                      float = 0.0



func get_based_good_effiency_production():
	return good.based_effiency_production


func get_good_production_efficiency():
	return good_production_efficiency


func get_production_efficiency():
	return production_efficiency
