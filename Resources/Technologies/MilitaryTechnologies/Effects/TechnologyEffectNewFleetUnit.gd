extends TechnologyEffect

class_name TechnologyEffectNewFleetUnit

@export var name_of_effect: String = "Новый тип корабля"

@export var target: Resource
	

func get_effect():
	return name_of_effect + ": " + tr(target.unit_name)


func activate_effects(client):
	client.military_bonuses.list_of_fleet_units.append(target)
