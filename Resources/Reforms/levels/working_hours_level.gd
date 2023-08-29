extends ReformLevel


class_name WorkingHoursReformLevel


@export var factory_efficiency: float = 0.0


func get_data():
	return {"factory_efficiency": factory_efficiency}


func activate_effects(client):
	client.economy_manager.production_efficiency_manager.prod_fact_efficiency_from_reforms += factory_efficiency


func deactivate_effects(client):
	client.economy_manager.production_efficiency_manager.prod_fact_efficiency_from_reforms -= factory_efficiency
