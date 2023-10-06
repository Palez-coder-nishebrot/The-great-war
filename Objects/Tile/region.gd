extends Node

class_name Region


const max_factories: int = 8

@export var starting_nat_mins:    Array[Culture]     = []
@export var starting_dom_culture: Culture           
@export var starting_factories:   Array[FactoryTipe] = []
@export var starting_dp:          Array[Good]        = []


var projects_list:              Array[ConstructionProject] = []
var factories_list:             Array[Factory]             = []
var DP_list:                    Array[DP]                  = []
var provinces_list:             Array[Province]            = []
var list_of_units:              Array                      = []

var produced_goods:             Array[Good]                = []

var population:   Population = Population.new()
var client_owner: Client


var region_name: String = ""


func _init():
	population.region = self
	client_owner = get_parent()
	SceneStorage.regions_manager.register_region(self)


func _ready():
	region_name = name
	var _err = ManagerDay.connect("allocate_workers_to_factories", Callable(self, "allocate_workers_to_factories"))
	_err     = ManagerDay.connect("allocate_workers_to_DP", Callable(self, "allocate_workers_to_DP"))
	for i in get_children():
		provinces_list.append(i)


func set_region():  # Вызывается, при стартовой настройке регионов
	var region_setter = RegionSetter.new()
	region_setter.spawn_enterprises(self)
	set_enterprises_efficiency(client_owner.economy_manager)


func set_new_owner(client: Client):
	for i in provinces_list:
		i.player = client
		i.set_region_color(client.national_color)
	
	register_enterprises(client, client_owner)
	client_owner.erase_region(self)
	client.register_region(self)
	
	client_owner = client


func set_enterprises_efficiency(economy_manager: EconomyManager):
	#var bonuses_from_railways = get_production_bonuses_from_railways()
	
	for i in factories_list + DP_list:
		i.enterprise_production_efficiency = economy_manager.get_enterprise_efficiency_production(i)
		i.good_production_efficiency       = economy_manager.get_good_production_efficiency(i.good)
		i.based_good_production_efficiency = i.good.get_based_good_production_effiency(i)
		i.production_efficiency            = i.enterprise_production_efficiency + i.good_production_efficiency + i.based_good_production_efficiency
		i.economy_manager                  = economy_manager
		
		if i is Factory:
			i.set_region_raw_bonus()


func register_enterprises(new_player, old_player = null):
	var new_player_manager = new_player.economy_manager
	
	var old_player_manager = old_player.economy_manager
	for i in DP_list:
		old_player_manager.DP_list.erase(i)
	for i in factories_list:
		old_player_manager.factories_list.erase(i)
	
	for i in DP_list + factories_list:
		i.economy_manager = new_player_manager
	
	new_player_manager.factories_list.append_array(factories_list)
	new_player_manager.DP_list.append_array(DP_list)


func append_produced_good(good):
	produced_goods.append(good)
	set_region_raw_bonus()


func delete_produced_good(good):
	produced_goods.erase(good)
	set_region_raw_bonus()


func set_region_raw_bonus():
	for i in factories_list:
		i.set_region_raw_bonus()
		

func get_open_factories_in_province():
	var list = []
	for i in factories_list:
		if i.closed == false:
			list.append(i)
	return list


func sort_open_factories():
	var last_el = factories_list[-1]
	for j in range(4):
		for factory in factories_list:
			if factories_list.find(factory) != last_el:
				var first = factory
				var second = factories_list[factories_list.find(factory) + 1]
				
				var first_index = factories_list.find(first)
				var second_index = factories_list.find(second)
				
				var first_profit = first.basic_profit
				var second_profit = second.basic_profit
				
				if first_profit < second_profit: # Если true, то элементы меняем местами
					Functions.swap(first_index, second_index, factories_list)


func build_factory(factory_type):
	var factory = ConstructionProject.new(factory_type, self, client_owner.economy_manager)
	projects_list.append(factory)


func allocate_workers_to_factories():
	if population.population_types[1].quantity == 0 and population.population_types[2].quantity == 0:
		return
	
	for factory in factories_list:
		if not factory.closed:
		
			var avaliable_jobs = factory.max_employed_number - (factory.workers_quantity + factory.clerks_quantity)
			var workers_quantity = factory.workers_quantity
			var clerks_quantity  = factory.clerks_quantity
			
			if avaliable_jobs > 0:
				var avaliable_jobs_for_workers  = snappedf(avaliable_jobs * 0.75, 1)
				var avaliable_jobs_for_clerks   = (avaliable_jobs - avaliable_jobs_for_workers)
				
				factory.workers_unit.allocate_workers_to_factories(factory, "workers_quantity", avaliable_jobs_for_workers)
				factory.clerks_unit.allocate_workers_to_factories(factory, "clerks_quantity", avaliable_jobs_for_clerks)
				
				avaliable_jobs = factory.max_employed_number - (workers_quantity + clerks_quantity)
				if avaliable_jobs > 0:
					factory.workers_unit.allocate_workers_to_factories(factory, "workers_quantity", avaliable_jobs)

				if factory.workers_unit.unemployed_quantity == 0 and factory.clerks_unit.unemployed_quantity == 0:
					return


func allocate_workers_to_DP():
	var workers_unit = population.population_types[0]
	workers_unit.unemployed_quantity = 0
	for dp in DP_list:
		dp.workers_unit     = workers_unit
		dp.workers_quantity = workers_unit.quantity / DP_list.size()
