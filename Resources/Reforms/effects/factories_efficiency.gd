extends ReformEffect

class_name ReformEffectFactoryEfficiency

func _init():
	target = "factories_efficiency_production"


func activate_effects(client):
	client.economy_manager.production_efficiency_manager.prod_fact_efficiency_from_reforms += value


func deactivate_effects(client):
	client.economy_manager.production_efficiency_manager.prod_fact_efficiency_from_reforms -= value
