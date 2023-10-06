extends Node

class_name Population


var population_types = [PopulationUnit.new(), PopulationUnit.new(), PopulationUnit.new(), PopulationUnit.new(), PopulationUnit.new()]

var MIGRATION_PATHS: Dictionary = {
	"to_labourers":   population_types[0],
	"to_craftsmen":   population_types[1],
	"to_clerks":      population_types[2],
	"to_bureaucrats": population_types[3],
	"to_soldiers":    population_types[4],
}

var region:              Region
var dominant_culture:    Culture
var national_minorities: Array[Culture]


func _init():
	population_types[0].population_type = load("res://Resources/population_types/worker.tres")
	population_types[1].population_type = load("res://Resources/population_types/factory_worker.tres")
	population_types[2].population_type = load("res://Resources/population_types/clerk.tres")
	population_types[3].population_type = load("res://Resources/population_types/bureaucrat.tres")
	population_types[4].population_type = load("res://Resources/population_types/soldiers.tres")
	
	for i in population_types:
		SceneStorage.population_manager.register_population_unit(i)


func clear_income():
	for pop_unit in population_types:
		pop_unit.income = 0


func set_soc_migration(region):
	for i in population_types:
		i.upgraded_status_quantity   = 0
		i.downgraded_status_quantity = 0
		if i.quantity > 0:
			var list_of_buildings = region.factories_list
			var migration_manager = i.population_type.migration_manager
			migration_manager.set_values(i, list_of_buildings, region.client_owner.economy_manager)
			
			for function in i.population_type.upgrade_class_paths:
				var value = migration_manager.call(function)
				var q     = migration_manager.want_to_upgrade_status
				check_soc_migration(i, value * q, MIGRATION_PATHS[function], list_of_buildings)
			
			for function in i.population_type.downgrade_class_paths:
				var value = migration_manager.call(function)
				var q     = migration_manager.want_to_downgrade_status
				check_soc_migration(i, value * q, MIGRATION_PATHS[function], list_of_buildings)


func check_soc_migration(pop_unit: PopulationUnit, quantity: int, target: PopulationUnit, factories_list: Array):
	if quantity > 0:
		execute_soc_migration(pop_unit, quantity, target, factories_list)


func execute_soc_migration(pop_unit_from: PopulationUnit, quantity: int, pop_unit_target: PopulationUnit, enterprises_list: Array):
	
	pop_unit_from.reduce_population(quantity, enterprises_list, pop_unit_from.population_type.workers_variable)
	pop_unit_target.increase_population(quantity)
	pop_unit_from.upgraded_status_quantity = quantity
