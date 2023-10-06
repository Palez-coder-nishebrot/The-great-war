extends MigrationManager


class_name LabourersMigrationManager


func to_craftsmen():
	var value = 0.01
	
	if not region_haves_factories:
		value -= 100
	
	if not region_haves_jobs_for_craftsmen:
		value -= 0.01
	
	if literacy > 20:
		value += 0.02
	
	if literacy > 30:
		value += 0.01
	
	if literacy > 40:
		value += 0.01
	
	if literacy > 50:
		value += 0.01
	
	if literacy > 60:
		value += 0.01
	
	if literacy > 70:
		value += 0.01
	
	if literacy > 80:
		value += 0.01
	return value


func to_soldiers():
	var value = -0.01
	
	if army_cost > 0.3:
		value += 0.01
	
	if army_cost > 0.4:
		value += 0.01
	
	if army_cost > 0.5:
		value += 0.01
	
	if army_cost > 0.6:
		value += 0.01
	
	if army_cost > 0.7:
		value += 0.01
	return value
