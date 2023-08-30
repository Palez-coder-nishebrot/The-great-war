extends Node


class_name SocMigrationManager


func get_pop_q_for_soc_migration(pop_unit):
	pass


func to_labourer():
	pass


func to_craftsmen(factories_list):
	var value = 0.2
	if region_haves_jobs_for_craftsmen(factories_list):
		value += 0.1
	if not region_haves_factories(factories_list):
		value -= 0.3
	
	value += check_literacy(0.0)


func to_clerks():
	pass


func region_haves_jobs_for_craftsmen(factories_list):
	for i in factories_list:
		if i.real_max_employed_number - i.get_workers_quantity() > 0:
			return true
	return false


func region_haves_factories(factories_list):
	if factories_list.size() > 0:
		return true
	return false


func check_literacy(literacy):
	if literacy > 90:
		return 0.9
	elif literacy > 80:
		return 0.8
	elif literacy > 70:
		return 0.7
	elif literacy > 60:
		return 0.6
	elif literacy > 50:
		return 0.5
	elif literacy > 40:
		return 0.4
	elif literacy > 30:
		return 0.3
	elif literacy > 20:
		return 0.2
	elif literacy > 10:
		return 0.1
	else:
		return 0.0
