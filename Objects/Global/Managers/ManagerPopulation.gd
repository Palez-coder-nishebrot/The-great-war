extends Node

func new_day(data):
#	if data.day == 1:
		for client in Players.list_of_players:
			for region in client.list_of_tiles:
				breakpoint


func migrate_to_workers(household, pop_manager):
	pop_manager.list_of_factory_workers.erase(household)
	pop_manager.list_of_workers.append(household)
	
	household.soc_class == "Worker"
	pass


func migrate_to_proletarians(household, pop_manager):
	pop_manager.list_of_workers.erase(household)
	pop_manager.list_of_factory_workers.append(household)
	
	household.soc_class == "Proletarian"
	pass


func migrate_to_clerks(household, pop_manager):
	pop_manager.list_of_factory_workers.erase(household)
	pop_manager.list_of_clerks.append(household)
	
	household.soc_class == "Clerk"
