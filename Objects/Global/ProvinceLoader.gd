extends Node

class_name ProvinceLoader

const education: Dictionary = {
	"Worker": 40.0,
	"Proletarian": 50.0,
	"Clerk":     80.0,
}

var pop_labourer_coef = 8000
var pop_worker_coef   = 12000
var pop_clerk_coef    = 40


func create_map(regions_list):
	for region in regions_list:
		spawn_population_units(region)
		#region.railways.level = i.railways
		#region.get_goods_in_province()
		
		region.start()
	print("creating regions finished")


func spawn_population_units(region):
	var player = region.player
	
	var ed = player.state_on_start.middle_value_education
	var workers         = region.population.population_types[0]
	var factory_workers = region.population.population_types[1]
	var clerks          = region.population.population_types[2]
	
	workers.quantity            = pop_labourer_coef * region.dp_goods.size()
	factory_workers.quantity    = get_required_workers(region.factory_goods) / 2
	factory_workers.unemployed_quantity = factory_workers.quantity
	
	clerks.quantity            = pop_clerk_coef * region.factory_goods.size()
	clerks.unemployed_quantity = clerks.quantity
	
	for i in region.population.population_types:
		i.region = region
		i.literacy = ed


func get_required_workers(list):
	var num = 0
	for i in list:
		num += i.initial_max_workers
	return num
