extends Node


const list_of_goods: Array = [
	"grain",
	"beasts",
	"alcohol",
	"glass",
	"clothes",
	"furniture",
	"el_appliances",
	"radio",
	"phone",
	"gas",
	"cars"
]

var list_of_needs: Array = []

func set_objects_of_goods():
	for good in list_of_goods:
		var object = Good.new()
		object.name_of_good = good
		list_of_needs.append(object)


func set_needs(population_manager):
	var needs_of_pop = load("res://Objects/Population/NeedsOfPopulation/NeedsOfPopulation.tres")
	for object in list_of_needs:
		object.quantity = 0.0
		object.quantity += (needs_of_pop.return_needs_for_household("Worker", object.name_of_good)) * population_manager.quantity_of_workers
		object.quantity += (needs_of_pop.return_needs_for_household("Proletarian", object.name_of_good)) * population_manager.quantity_of_factory_workers
		object.quantity += (needs_of_pop.return_needs_for_household("Clerk", object.name_of_good)) * population_manager.quantity_of_clerks
