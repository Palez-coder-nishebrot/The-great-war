extends Node

const factories: Dictionary = {
	"Steel_plant":             "res://Resources/Factories/TipesOfFactories/SteelPlant.tres",
	"Textile_factory":         "res://Resources/Factories/TipesOfFactories/TextileFactory.tres",
	"Glass_factory":           "res://Resources/Factories/TipesOfFactories/GlassFactory.tres",
	"Electrical_appliance_factory": "res://Resources/Factories/TipesOfFactories/ElectricalApplianceFactory.tres",
	"Electrical_parts_factory": "res://Resources/Factories/TipesOfFactories/ElectricalPartsFactory.tres",
	"Lumber_plant": "res://Resources/Factories/TipesOfFactories/LumberPlant.tres",
	"Cars_factory": "res://Resources/Factories/TipesOfFactories/CarsFactory.tres",
	"Telegraph_factory": "res://Resources/Factories/TipesOfFactories/TelegraphFactory.tres",
	"Phone_factory": "res://Resources/Factories/TipesOfFactories/PhoneFactory.tres",
	"Radio_factory": "res://Resources/Factories/TipesOfFactories/RadioFactory.tres",
	"Furniture_factory": "res://Resources/Factories/TipesOfFactories/FurnitureFactory.tres",
	"Distillery": "res://Resources/Factories/TipesOfFactories/Distillery.tres",
	"Clothes_factory": "res://Resources/Factories/TipesOfFactories/ClothesFactory.tres",
	"Canning_factory": "res://Resources/Factories/TipesOfFactories/CanningFactory.tres",
	"Gas_factory": "res://Resources/Factories/TipesOfFactories/GasFactory.tres",
	"Airplane_factory": "res://Resources/Factories/TipesOfFactories/AirplaneFactory.tres",
	"Mech_parts_factory": "res://Resources/Factories/TipesOfFactories/MechPartsFactory.tres",
	
	"Rubber_factory": "res://Resources/Factories/TipesOfFactories/RubberFactory.tres",
	"Oil_factory": "res://Resources/Factories/TipesOfFactories/OilFactory.tres",
	"Senthetic_textile_factory": "res://Resources/Factories/TipesOfFactories/SentheticTextileFactory.tres",
}

const education: Dictionary = {
	"Worker": 40.0,
	"Proletarian": 50.0,
	"Craftsman": 40.0,
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
		var factories = []
		var client = region.player
		
		client.list_of_tiles.append(region)
		region.population_manager = load("res://Objects/Population/PopulationManager.gd").new()
		region.population_manager.province = region
		region.population_manager.player = client
		region.get_parent().get_parent().purchase_manager.list_of_population_managers.append(region.population_manager)
		
		for factory in i.factories:
			region.list_of_buildings.append(create_factory(factory, region.get_parent().get_parent(), region))
		
		for resource in i.resources:
			region.resources[resource] = 1
		
		var middle_education = create_household(i, region)
		
		region.population_manager.education = client.middle_value_education
		
		region.railways.level = i.railways
		region.population_manager.needs.set_objects_of_goods()
		region.population_manager.needs.set_needs(region.population_manager)
		region.get_goods_in_province()
		
		game.list_of_provinces.append(region)
	
#	for i in Players.list_of_players:
#		i.population_manager.new_day()
		
			

func create_factory(factory_name, game, region):
	var factory_object = load(factories[factory_name])
	var factory = Factory.new()
	factory.closed = false
	factory.good = factory_object.good
	factory.name_of_factory = factory_object.name_of_factory
	factory.province = region
	game.factory_manager.list_of_factories.append(factory)
	region.player.list_of_factories.append(factory)
	
	var raw = factory_object.raw
	for i in raw:
		factory.purchase[i.good] = i.quantity
#	if production_goods.has(factory.good):
#		factory.real_max_employed_number = 1
#		factory.max_employed_number = 1
	
	return factory
		
	
func create_household(obj, region):
	var ed = 0
	region.population_manager.quantity_of_workers = obj.workers
	region.population_manager.quantity_of_factory_workers = obj.factory_workers
	ed += education.Worker * obj.workers
	ed += education.Proletarian * obj.factory_workers
	
	ed = ed / (obj.factory_workers + obj.workers)
	return ed
