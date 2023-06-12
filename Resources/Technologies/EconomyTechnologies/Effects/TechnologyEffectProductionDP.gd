extends TechnologyEffect

class_name TechnologyEffectProductionDP

@export var name_of_effect: String = "Производительность ДП"

@export var power: float = 0.0


func get_effect():
	var bonus = (power - 1) * 100
	return name_of_effect + ": +" + str(bonus)  + "%"


func activate_effects(client):
	var bonus = power - 1
	client.economic_bonuses.DP_efficiency_production += bonus
