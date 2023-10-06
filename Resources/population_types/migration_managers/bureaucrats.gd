extends MigrationManager


class_name BureaucratsMigrationManager



func to_craftsmen():
	var value = -0.02
	
	if education_cost < 0.2:
		value += 0.01
	
	if bureaucracy_cost < 0.3:
		value += 0.01
	
	if bureaucracy_cost < 0.5:
		value += 0.01
	return value
