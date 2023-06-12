extends ReformEffect

class_name ReformEffectPensions

@export var effect_name: String = "pensions"

func _init():
	target = "pensions"


func activate_effects(client):
	client.economic_bonuses.pensions += value


func deactivate_effects(client):
	client.economic_bonuses.pensions -= value
