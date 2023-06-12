extends Node

class_name ProvinceLoader

const education: Dictionary = {
	"Worker": 40.0,
	"Proletarian": 50.0,
	"Clerk":     80.0,
}


func create_map(dict_of_regions, game):
	var file = ResourceLoader.load("res://Objects/Provinces/SavedRegions.tres")
	
	for i in file.regions:
		var region = dict_of_regions[i.name_of_province]
		
		SceneStorage.regions_manager.register_region(region)
		
		region.population_manager = load("res://Objects/Population/PopulationManager.gd").new()
		region.population_manager.province = region
		region.get_parent().get_parent().purchase_manager.list_of_population_managers.append(region.population_manager)
		
		var _middle_literacy = spawn_population_units(i, region)
		
		set_factories(region, i.factories)
		set_resourses(region, i.resources)
		
		region.railways.level = i.railways
		region.get_goods_in_province()
		
		game.list_of_regions.append(region)
	print("creating regions finished")


func set_factories(region, factories_list):
	for factory in factories_list:
		region.list_of_buildings.append(create_factory(factory, region.get_parent().get_parent(), region))


func set_resourses(region, resources):
	for good in resources:
		var DP_obj = DP.new()
		DP_obj.good = good
		region.DP_list.append(DP_obj)


func create_factory(factory_type_resource, game, region):
	var factory = generate_factory(factory_type_resource, region)
	game.factory_manager.list_of_factories.append(factory)
	
	return factory


func spawn_population_units(obj, region):
	var ed = 0
	var workers         = region.population.population_types[0]
	var factory_workers = region.population.population_types[1]
	var clerks          = region.population.population_types[2]
	
	workers.quantity         = obj.workers
	factory_workers.quantity = obj.factory_workers
	
	workers.region         = region
	factory_workers.region = region
	clerks.region          = region
	ed += education.Worker * obj.workers
	ed += education.Proletarian * obj.factory_workers
	
	ed = ed / (obj.factory_workers + obj.workers)
	return ed


func generate_factory(factory_resource, region = null):
	var factory = Factory.new()
	factory.closed = false
	factory.name_of_factory = factory_resource.name_of_factory
	factory.good = factory_resource.good
	factory.type_factory = factory_resource
	factory.province = region
	set_factory_storage(factory, factory_resource.raw)
	factory.factory_equipment = factory_resource.factory_equipment
	if region != null:
		factory.workers_unit = region.population.population_types[1]
	return factory


func set_factory_storage(factory, raw_list):
	for raw in raw_list:
		var storage_good = StorageGood.new()
		storage_good.set_storage_good(raw.good, raw.quantity)
		factory.raw_storage.append(storage_good)
	pass
