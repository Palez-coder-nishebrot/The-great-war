extends Node

class_name SocMigrationManager

var labourer_res  = load("res://Resources/population_types/worker.tres")
var craftsman_res = load("res://Resources/population_types/factory_worker.tres")
var clerk_res     = load("res://Resources/population_types/clerk.tres")


func get_data_pop_migration(pop_unit, list_of_buildings):
	var literacy           = pop_unit.literacy
	var unemployed_percent = pop_unit.unemployed_quantity / pop_unit.quantity
	var pop_quantity = get_pop_q_for_soc_migration(pop_unit)
	var pop_type_target
	pop_unit.want_to_upgrade_status = pop_quantity
	
	var migration_to_labourer  = to_labourer(list_of_buildings, pop_unit.welfare)
	var migration_to_craftsmen = to_craftsmen(list_of_buildings, literacy, unemployed_percent)
	var migration_to_clerks    = to_clerks(list_of_buildings, literacy)
	
	match pop_unit.population_type:
		
		labourer_res:
			pop_quantity = snapped(pop_quantity * migration_to_craftsmen, 1)
			pop_type_target = craftsman_res
		
		craftsman_res:
			var to_clerks = snapped(pop_quantity * migration_to_clerks, 1)
			var to_lab    = snapped(pop_quantity * migration_to_labourer, 1)
			
			if to_clerks > to_lab:
				pop_quantity    = to_clerks
				pop_type_target = clerk_res
			else:
				pop_quantity    = to_lab
				pop_type_target = labourer_res
		
		clerk_res:
			pop_quantity = snapped(pop_quantity * migration_to_craftsmen, 1)
			pop_type_target = labourer_res
	
	if pop_quantity > 0:
		return {
			"pop_type_target": pop_type_target,
			"quantity":        pop_quantity,
		}
	else:
		return {
			"pop_type_target": null,
			"quantity":        0,
		}


func get_pop_q_for_soc_migration(pop_unit: PopulationUnit):
	var percent = 0.0
	var pluralism = pop_unit.pluralism
	
	match pop_unit.welfare:
		0:
			percent += 0.08
		1:
			percent += 0.02
		2:
			percent += 0.01
	
	if pluralism > 0 and pluralism < 5:
		percent += 0.01
	elif pluralism > 5:
		percent += 0.02
	
	return snapped(pop_unit.quantity * percent, 1)


func to_labourer(list_of_buildings, welfare):
	var value = 0.0
	
	if not region_haves_jobs_for_craftsmen(list_of_buildings):
		value += 0.1
		
	if welfare == 0:
		value += 0.1
	
	return value


func to_craftsmen(list_of_buildings, literacy, unemployed_percent):
	var value = 0.1
	if not region_haves_jobs_for_craftsmen(list_of_buildings):
		value -= 100
	if not region_haves_factories(list_of_buildings):
		value -= 100
	
	value += check_literacy(literacy)
	
	if unemployed_percent > 0.1:
		value += 0.05
	if unemployed_percent > 0.4:
		value += 0.05
	if unemployed_percent > 0.6:
		value += 0.05
	
	return value


func to_clerks(list_of_buildings, literacy):
	var value = -0.1
	if not region_haves_jobs_for_craftsmen(list_of_buildings):
		value -= 100
	
	if literacy > 70:
		value += 0.1
	
	if literacy > 80:
		value += 0.02
	
	if literacy > 90:
		value += 0.01
	
	return value


func region_haves_jobs_for_craftsmen(list_of_buildings):
	for i in list_of_buildings:
		if i.real_max_employed_number - i.get_workers_quantity() > 0 and i.closed == false:
			return true
	return false


func region_haves_factories(list_of_buildings):
	if list_of_buildings.size() > 0:
		return true
	return false


func check_literacy(literacy):
	if literacy > 90:
		return 0.07
	elif literacy > 80:
		return 0.06
	elif literacy > 70:
		return 0.05
	elif literacy > 60:
		return 0.04
	elif literacy > 50:
		return 0.03
	elif literacy > 40:
		return 0.02
	else:
		return -0.09
