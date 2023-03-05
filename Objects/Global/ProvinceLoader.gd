extends Node

const education: Dictionary = {
	"Worker": 40.0,
	"Proletarian": 50.0,
	"Clerk":     80.0,
}

var variables: Dictionary = {
	"Worker": "quantity_of_workers",
	"Proletarian": "quantity_of_workers",
	"Clerk":     "quantity_of_clerks",
}

var production_goods: Array = [
	"steel",
	"glass",
	"textile",
	"el_parts",
	"lumber",
]

func create_map(dict_of_regions, game):
	var file = ResourceLoader.load("res://Objects/Provinces/SavedRegions.tres")
	
	for i in file.regions:
		var region = dict_of_regions[i.name_of_province]
		var client = region.player
		
		client.list_of_tiles.append(region)
		region.population_manager = load("res://Objects/Population/PopulationManager.gd").new()
		region.population_manager.province = region
		region.population_manager.player = client
		region.get_parent().get_parent().purchase_manager.list_of_population_managers.append(region.population_manager)
		
		for factory in i.factories:
			region.list_of_buildings.append(create_factory(factory, region.get_parent().get_parent(), region))
		
		for resource in i.resources:
			region.resources.append(resource)
		
		var _middle_education = create_household(i, region)
		
		region.population_manager.education = client.middle_value_education
		
		region.railways.level = i.railways
		region.population_manager.needs.set_objects_of_goods()
		region.population_manager.needs.set_needs(region.population_manager)
		region.get_goods_in_province()
		
		game.list_of_regions.append(region)
	

func create_factory(factory_object, game, region):
	var factory = Factory.new()
	factory.closed = false
	factory.good = factory_object.good
	factory.name_of_factory = factory_object.name_of_factory
	factory.province = region
	factory.raw = factory_object.raw
	factory.type_factory = factory_object
	game.factory_manager.list_of_factories.append(factory)
	region.player.list_of_factories.append(factory)
	
	return factory


func create_household(obj, region):
	var ed = 0
	var workers         = region.population.population_types[0]
	var factory_workers = region.population.population_types[1]
	var clerks          = region.population.population_types[2]
	
	workers.quantity         = obj.workers
	factory_workers.quantity = obj.factory_workers
	
	workers.region         = region
	factory_workers.region = region
	clerks.region          = region
	#region.population_manager.quantity_of_workers = obj.workers
	#region.population_manager.quantity_of_factory_workers = obj.factory_workers
	ed += education.Worker * obj.workers
	ed += education.Proletarian * obj.factory_workers
	
	ed = ed / (obj.factory_workers + obj.workers)
	ManagerDay.connect("clear_income_in_pop_units", region.population, "clear_income")
	return ed
