extends ReformEffect

class_name ReformEffectPensions


func _init():
	target = "pensions"


func activate_effects(client):
	client.economic_bonuses.pensions += value


func deactivate_effects(client):
	client.economic_bonuses.pensions -= value
