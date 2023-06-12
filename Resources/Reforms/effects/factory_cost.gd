extends ReformEffect

class_name ReformEffectFactoryCost

@export var effect_name: String = "factory_cost"

func _init():
	target = "factory_cost"


func activate_effects(client):
	client.factory_cost += value


func deactivate_effects(client):
	client.factory_cost -= value
