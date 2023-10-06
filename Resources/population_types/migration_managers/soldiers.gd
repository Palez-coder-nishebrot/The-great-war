extends MigrationManager


class_name SoldiersMigrationManager


func to_craftsmen():
	var value = -0.02
	
	if army_cost < 0.3:
		value += 0.02
	
	if literacy > 30:
		value += 0.01
	if literacy > 40:
		value += 0.01
	
	if not region_haves_jobs_for_craftsmen:
		value -= 100
	return value


func to_bureaucrats():
	var value = -0.02
	
	if army_cost < 0.3:
		value += 0.01
	
	if bureaucracy_cost > 0.3:
		value += 0.01
	
	if education_cost > 0.2:
		value += 0.01
	
	if literacy > 50:
		value += 0.01
	if literacy > 60:
		value += 0.01
	return value
