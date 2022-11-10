extends Resource


func check(pop_manager):
	for i in pop_manager.province.list_of_buildings:
		if i.quantity_of_workers < i.max_employed_number:
			return 1
	return 0
