extends Resource


func check(pop_manager):
	if pop_manager.list_of_workers.size() > 2:
		return 1
	else:
		return 0
