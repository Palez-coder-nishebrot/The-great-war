extends Node

class_name Population

@export var population_types = [PopulationUnit.new(), PopulationUnit.new(), PopulationUnit.new()] # (Array, Resource)


func _init():
	population_types[0].population_type = load("res://Resources/population_types/worker.tres")
	population_types[1].population_type = load("res://Resources/population_types/factory_worker.tres")
	population_types[2].population_type = load("res://Resources/population_types/clerk.tres")
	
	for i in population_types:
		SceneStorage.population_manager.register_population_unit(i)


func clear_income():
	for pop_unit in population_types:
		pop_unit.income = 0

#func set_needs():
#	for population_unit in population_types:
#		for good in population_unit.population_type.needs:
#
#	pass
