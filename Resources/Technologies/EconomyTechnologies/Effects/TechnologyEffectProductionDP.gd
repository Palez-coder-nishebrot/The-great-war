extends TechnologyEffect

class_name TechnologyEffectProductionDP

export(String) var name_of_effect = "Производительность ДП"

export(float) var power = 0.0


func get_effect():
	var bonus = (power - 1) * 100
	return name_of_effect + ": +" + str(bonus)  + "%"


func activate_effects(client):
	var bonus = power - 1
	client.economic_bonuses.DP_efficiency_production += bonus
