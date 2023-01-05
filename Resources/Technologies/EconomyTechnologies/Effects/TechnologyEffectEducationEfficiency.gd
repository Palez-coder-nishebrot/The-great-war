extends TechnologyEffect

class_name TechnologyEffectEducationEfficiency

export(String) var name_of_effect = "Эффективность обучения"

export(int) var power = 10


func get_effect():
	return name_of_effect + ": +" + str(power) + "%"


func activate_effects(client):
	client.economic_bonuses.education_efficiency += power / 100
