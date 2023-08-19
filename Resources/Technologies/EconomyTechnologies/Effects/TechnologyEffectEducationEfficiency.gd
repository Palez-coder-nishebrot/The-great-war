extends TechnologyEffect

class_name TechnologyEffectEducationEfficiency

@export var name_of_effect: String = "Эффективность обучения"

@export var power: int = 10


func get_effect():
	return name_of_effect + ": +" + str(power) + "%"


func activate_effects(_client):
	pass
#	client.economic_bonuses.education_efficiency += power / 100
