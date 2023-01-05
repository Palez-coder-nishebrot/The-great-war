extends TechnologyEffect

class_name TechnologyEffectInflation

export(String) var name_of_effect = "Прирост инфляции"

export(int) var power = 10


func get_effect():
	return name_of_effect + ": +" + str(power) + "%"


func activate_effects(client):
	client.economic_bonuses.growth_of_inflation += power / 100
