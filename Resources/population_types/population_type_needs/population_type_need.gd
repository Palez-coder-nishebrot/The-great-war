extends Resource

class_name NeededGood

@export var util:     float = 0
@export var quantity: float = 0.1
@export var good_type: Resource



func get_good_quantity():
	return snappedf(quantity * 0.001, 0.00001)
