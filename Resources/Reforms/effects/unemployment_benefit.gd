extends ReformEffect

class_name ReformEffectUnemploymentBenefit


func _init():
	target = "unemployment_benefit"


func activate_effects(client):
	client.economic_bonuses.unemployment_benefit += value


func deactivate_effects(client):
	client.economic_bonuses.unemployment_benefit -= value
