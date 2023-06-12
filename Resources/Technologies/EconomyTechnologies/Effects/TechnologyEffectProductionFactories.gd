extends TechnologyEffect

class_name TechnologyEffectProductionFactories

@export var name_of_effect: String = "Производительность заводов"

@export var power: float = 0.0

func get_effect():
	var bonus = (power - 1.0) * 100.0
	return name_of_effect + ": +" + str(bonus)  + "%"


func activate_effects(client):
	var bonus = power - 1
	client.economic_bonuses.factories_efficiency_production += bonus
