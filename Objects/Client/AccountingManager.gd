extends RefCounted

var population_units_getter: Callable
var regions_list_getter:     Callable

var labour_quantity = 0
var workers_quantity = 0
var clerks_quantity = 0

var unemployed_quantity = 0
var population_quantity = 0
var population_welfare = 0
var population_literacy = 0


func set_info():
	var population_units_list = population_units_getter.call()
	var regions_list          = regions_list_getter.call()
	
	check_population_types(regions_list)
	check_unemployed_quantity(population_units_list)
	check_population_welfare(population_units_list)
	check_population_quantity(population_units_list)
	check_population_literacy(population_units_list)


func check_unemployed_quantity(population_units_list):
	var q = 0
	for i in population_units_list:
		q += i.unemployed_quantity
	return q


func check_population_welfare(population_units_list):
	var amount = 0.0
	for i in population_units_list:
		amount += i.welfare
	return amount / float(population_units_list.size())


func check_population_quantity(population_units_list):
	var amount = 0
	for i in population_units_list:
		amount += i.quantity
	return amount
	

func check_population_literacy(population_units_list):
	var amount = 0.0
	for i in population_units_list:
		amount += i.literacy
	return amount / float(population_units_list.size())


func check_population_types(regions_list):
	labour_quantity = 0
	workers_quantity = 0
	clerks_quantity = 0
	
	for region in regions_list:
		var pop_list = region.population.population_types
		labour_quantity += pop_list[0]
		workers_quantity += pop_list[1]
		clerks_quantity += pop_list[2]
