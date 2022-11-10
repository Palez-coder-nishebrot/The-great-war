extends Node

class_name PopulationManager

var client

func _init(client):
	self.client = client
	#new_day()#client, data)

func update_expenses_education():
	var expenses = client.education * client.population
	client.accounting["education"] += expenses
	client.budget -= expenses
	update_education()
	

func update_quantity_of_population():
	client.population = 0
	for i in client.list_of_tiles:
		client.population += i.population_manager.get_quantity_of_population()


func update_education():
	for i in client.list_of_soc_classes:
		i.education += client.education * 0.03


func update_stability():
	pass


func update_population_growth():
	pass


func update_research_points():
	client.researching_points += client.middle_value_education * 0.1
	pass


func new_day():#client, data):
	for region in client.list_of_tiles:
		#print("Проверка")
		var migration_to_worker      = load("res://Resources/SocialMigration/SocClasses/Worker.tres").check(region.population_manager)
		var migration_to_proletarian = load("res://Resources/SocialMigration/SocClasses/Proletarian.tres").check(region.population_manager)
		var migration_to_clerk       = load("res://Resources/SocialMigration/SocClasses/Clerk.tres").check(region.population_manager)
		var pop_manager = region.population_manager
		
		#region.list_of_workers[0]
		
		if migration_to_worker:
			migrate_to_workers(pop_manager.list_of_factory_workers[0], pop_manager)
			pass
		elif migration_to_proletarian:
			migrate_to_workers(pop_manager.list_of_workers[0], pop_manager)
		
		if migration_to_clerk:
			migrate_to_workers(pop_manager.list_of_factory_workers[0], pop_manager)
		
		yield(client.game, "new_day")


func migrate_to_workers(household, pop_manager):
	pop_manager.list_of_factory_workers.erase(household)
	pop_manager.list_of_workers.append(household)
	
	household.soc_class == "Worker"
	print("migrate_to_workers ", pop_manager.province.player.name_of_country)


func migrate_to_proletarians(household, pop_manager):
	pop_manager.list_of_workers.erase(household)
	pop_manager.list_of_factory_workers.append(household)
	
	household.soc_class == "Proletarian"
	print("migrate_to_Proletarian")


func migrate_to_clerks(household, pop_manager):
	pop_manager.list_of_factory_workers.erase(household)
	pop_manager.list_of_clerks.append(household)
	
	household.soc_class == "Clerk"
	print("migrate_to_Clerk")
