extends Node


const list_of_goods: Array = [
	"grain",
	"beasts",
	"clothes",
	"furniture",
	"glass",
	"alcohol",
	"tabaco",
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


func set_needs(list_of_soc_classes):
	var needs_of_pop = load("res://Objects/Population/NeedsOfPopulation/NeedsOfPopulation.tres")
	for object in list_of_needs:
		object.quantity = 0.0
		for household in list_of_soc_classes:
			object.quantity += needs_of_pop.return_needs_for_household(household.soc_class, object.name_of_good)
