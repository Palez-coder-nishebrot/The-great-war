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
		
		region.set_region()
	print("creating regions finished")


func spawn_population_units(region):
	var player = region.client_owner
	
	var ed = player.state_on_start.middle_value_education
	var workers         = region.population.population_types[0]
	var factory_workers = region.population.population_types[1]
	var clerks          = region.population.population_types[2]
	var bureaucrat      = region.population.population_types[3]
	
	workers.quantity            = pop_labourer_coef * region.starting_dp.size()
	factory_workers.quantity    = get_required_workers(region.starting_factories) / 2
	factory_workers.unemployed_quantity = factory_workers.quantity
	
	#clerks.quantity            = pop_clerk_coef * region.starting_factories.size()
	#clerks.unemployed_quantity = clerks.quantity
	
	bureaucrat.quantity        = 100
	
	for i in region.population.population_types:
		i.region = region
		i.literacy = ed
	set_cultures(region)


func set_cultures(region):
	region.population.national_minorities = region.starting_nat_mins.duplicate()
	region.population.dominant_culture    = region.starting_dom_culture


func get_required_workers(list):
	var num = 0
	for i in list:
		num += i.initial_max_workers
	return num
