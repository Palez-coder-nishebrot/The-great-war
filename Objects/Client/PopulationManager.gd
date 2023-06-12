extends Node

class_name PopulationManager

var client
var population_growth:    float = 1.0  # Это значение мы тоже будем умножать!
var education_efficiency: float = 1.0  # Это значение мы тоже будем умножать!
#var manager_of_migration_workers      = load("res://Resources/SocialMigration/SocClasses/Worker.tres")
#var manager_of_migration_proletarians = load("res://Resources/SocialMigration/SocClasses/Proletarian.tres")
#var manager_of_migration_clerks       = load("res://Resources/SocialMigration/SocClasses/Clerk.tres")


func _init(client_):
	self.client = client_
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
	for i in client.list_of_tiles:
		i.population_manager.education += client.education * 0.01


func update_stability():
	pass


func update_population_growth():
	for i in client.list_of_tiles:
		i.population_manager.update_population_growth()


func update_research_points():
	var points = (client.middle_value_education + client.education + 10) * 0.2
	client.researching_points += points
	client.growth_of_researching_points = points


func migrate_to_workers(pop_manager):
	pop_manager.quantity_of_factory_workers -= 1
	pop_manager.quantity_of_workers         += 1
	
	#print("migrate_to_workers ", pop_manager.province.player.name_of_country)


func migrate_to_proletarians(pop_manager):
	pop_manager.quantity_of_workers         -= 1
	pop_manager.quantity_of_factory_workers += 1
	
	#print("migrate_to_Proletarian")


func migrate_to_clerks(pop_manager):
	pop_manager.quantity_of_factory_workers -= 1
	pop_manager.quantity_of_clerks          += 1
	
	#print("migrate_to_Clerk")
