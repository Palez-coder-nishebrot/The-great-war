extends Resource

class_name NeededGood

@export var is_luxury_need: bool  = false
@export var util:           float = 0
@export var quantity:       float = 0.1
@export var good_type: Resource



func get_good_quantity():
	return snappedf(quantity * PopulationWorldManager.POP_COEF * 0.1, 0.000001)


func get_good(pop_unit = null):
	if good_type == null:
		return pop_unit.region.population.dominant_culture.national_drink
	else:
		return good_type
