extends ReformEffect

class_name ReformEffectFactoryEfficiency

@export var effect_name: String = "factories_efficiency_production"

func _init():
	target = "factories_efficiency_production"


func activate_effects(client):
	client.economic_bonuses.factories_efficiency_production += value


func deactivate_effects(client):
	client.economic_bonuses.factories_efficiency_production -= value
