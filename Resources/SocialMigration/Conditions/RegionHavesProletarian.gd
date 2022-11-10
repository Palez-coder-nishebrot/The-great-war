extends Node


func check(pop_manager):
	if pop_manager.list_of_factory_workers.size() > 2:
		return 1
	else:
		return 0
