extends ReformLevel


class_name LabourProtectionReformLevel


@export var factory_cost: float = 0.0


func get_data():
	return {"factory_cost": factory_cost}


func activate_effects(client):
	client.economy_manager.factory_cost += factory_cost


func deactivate_effects(client):
	client.economy_manager.factory_cost -= factory_cost
