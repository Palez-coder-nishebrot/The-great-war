extends TechnologyEffect

class_name TechnologyEffectAttack

@export var name_of_effect: String = "Атака"

@export var power: int = 0

@export var target: Resource
	

func get_effect():
	return name_of_effect + " " + tr(target.unit_name) + ": +" + str(power)


func activate_effects(client):
	client.military_bonuses.get(target).attack += power
