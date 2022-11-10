extends Node

func new_day(data):
	if data.day == 1:
		for client in Players.list_of_players:
			for region in client.list_of_tiles:
				var migration_to_worker      = load("res://Resources/SocialMigration/SocClasses/Worker.tres").check(region.population_manager)
				var migration_to_proletarian = load("res://Resources/SocialMigration/SocClasses/Proletarian.tres").check(region.population_manager)
				var migration_to_clerk       = load("res://Resources/SocialMigration/SocClasses/Clerk.tres").check(region.population_manager)
				var pop_manager = region.population_manager
				
				region.list_of_workers[0]
				
				if migration_to_worker:
					migrate_to_workers(region.list_of_factory_workers[0], pop_manager)
					pass
				elif migration_to_proletarian:
					migrate_to_workers(region.list_of_workers[0], pop_manager)
				
				if migration_to_clerk:
					migrate_to_workers(region.list_of_factory_workers[0], pop_manager)


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
