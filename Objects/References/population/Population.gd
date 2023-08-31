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


func set_soc_migration(region):
	for i in population_types:
		i.upgraded_status_quantity   = 0
		i.downgraded_status_quantity = 0
		if i.quantity > 0:
			var list_of_buildings = region.list_of_buildings
			var enterprises_list = region.get(i.population_type.enterprises_list_variable)
			var data = i.soc_migration_manager.get_data_pop_migration(i, list_of_buildings)
			if data.pop_type_target != null:
				execute_soc_migration(i.population_type, data.quantity, data.pop_type_target, enterprises_list)


func execute_soc_migration(pop_type: PopulationType, quantity: int, pop_type_target: PopulationType, enterprises_list: Array):
	var pop_unit_from   = population_types[pop_type.index_in_pop_types_list]
	var pop_unit_target = population_types[pop_type_target.index_in_pop_types_list]
	
	pop_unit_from.reduce_population(quantity, enterprises_list, pop_type.workers_variable)
	pop_unit_target.increase_population(quantity)
	pop_unit_from.upgraded_status_quantity = quantity
