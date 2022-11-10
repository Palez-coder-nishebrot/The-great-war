extends Resource


func check(pop_manager):
	if pop_manager.quantity_of_unemployed >= 1:
		return 1
	else:
		return 0
