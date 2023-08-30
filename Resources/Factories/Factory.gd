extends Resource

class_name FactoryTipe

@export var name_of_factory: String = ""

@export var raw: Array[Raw] = []

@export var good: Resource

@export var construction_days:   int = 3
@export var initial_max_workers: int = 10000


func generate_factory(region = null, economy_manager = null):
	var factory             = Factory.new()
	factory.closed          = false
	factory.name_of_factory = name_of_factory
	factory.good            = good
	factory.type_factory    = self
	factory.province        = region
	factory.economy_manager = economy_manager
	factory.real_max_employed_number = initial_max_workers
	factory.max_employed_number      = initial_max_workers
	
	set_factory_storage(factory)
	if region != null:
		factory.workers_unit = region.population.population_types[1]
		factory.clerks_unit  = region.population.population_types[2]
	return factory


func set_factory_storage(factory):
	for raw_ in raw:
		var storage_good = StorageGood.new()
		storage_good.set_storage_good(raw_.good, raw_.get_good_quantity())
		factory.raw_storage.append(storage_good)
