extends MigrationManager


class_name ClerksMigrationManager


func to_bureaucrats():
	var value = 0.0
	
	return value
	pass


func to_craftsmen():
	var value = 0.0
	
	if region_haves_jobs_for_craftsmen:
		value += 0.01
	
	if not region_haves_factories:
		value += 0.1
	
	if unemployed_percent > 0.2:
		value += 0.01
	
	if unemployed_percent > 0.4:
		value += 0.01
	
	if unemployed_percent > 0.5:
		value += 0.01
	return value


func to_soldiers():
	var value = -0.02
	
	if unemployed_percent > 0.3:
		value += 0.01
	
	if unemployed_percent > 0.5:
		value += 0.01
	
	if army_cost > 0.3:
		value += 0.01
	
	if army_cost > 0.4:
		value += 0.01
	
	if army_cost > 0.5:
		value += 0.01
	return value
