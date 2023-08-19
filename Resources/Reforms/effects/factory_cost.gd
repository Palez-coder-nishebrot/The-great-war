extends ReformEffect

class_name ReformEffectFactoryCost


func _init():
	target = "factory_cost"


func activate_effects(client):
	client.economy_manager.factory_cost += value


func deactivate_effects(client):
	client.economy_manager.factory_cost -= value
