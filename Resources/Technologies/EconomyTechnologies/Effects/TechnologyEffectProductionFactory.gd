extends TechnologyEffect

class_name TechnologyEffectProductionFactory

export(String) var name_of_effect = "Производительность"

export(float) var power = 0.0

export(Resource) var target


func get_effect():
	var bonus = (power - 1) * 100
	return name_of_effect + " " + target.name_of_factory + ": +" + str(bonus)  + "%"


func activate_effects(client):
	var bonus = power - 1
	client.economic_bonuses.factory_efficiency_production[target] += bonus
