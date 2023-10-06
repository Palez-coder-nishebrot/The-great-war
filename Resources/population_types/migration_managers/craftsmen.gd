extends MigrationManager


class_name CraftsmenMigrationManager


func to_clerks():
	var value = -0.01
	
	if not region_haves_jobs_for_craftsmen:
		value -= 100
	
	if unemployed_percent > 0.1:
		value -= 0.01
	
	if literacy > 70.0:
		value += 0.01
	
	if literacy > 80.0:
		value += 0.01
	
	if literacy > 90.0:
		value += 0.01
	return value
	
	
func to_labourers():
	var value = -0.02
	
	if not region_haves_factories:
		value += 0.01
	
	if not region_haves_jobs_for_craftsmen:
		value += 0.02
	
	if unemployed_percent > 0.2:
		value += 0.01
	
	if unemployed_percent > 0.3:
		value += 0.01
		
	if unemployed_percent > 0.4:
		value += 0.01
	
	if unemployed_percent > 0.5:
		value += 0.01
	return value


func to_soldiers():
	var value = -0.02
	
	if army_cost > 0.2:
		value += 0.01
	
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
