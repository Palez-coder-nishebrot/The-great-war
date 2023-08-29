extends Resource

class_name Raw

@export var good: Resource

@export var quantity: float = 0.01


func get_good_quantity():
	return quantity * 0.01
