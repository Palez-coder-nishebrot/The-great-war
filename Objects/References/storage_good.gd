extends RefCounted

class_name StorageGood

var good:              Resource
var quantity:          float = 0
var required_quantity: float = 0
var purchase_price:    float = 0


func set_storage_good(good_, quantity_):
	good = good_
	required_quantity = quantity_


func get_good_quantity():
	return quantity


func get_good_required_quantity(factory):
	return snappedf(required_quantity * factory.get_workers_quantity(), 0.01)
