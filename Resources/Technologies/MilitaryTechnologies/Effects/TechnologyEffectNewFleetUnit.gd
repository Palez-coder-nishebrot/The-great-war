extends TechnologyEffect

class_name TechnologyEffectNewFleetUnit

export(String) var name_of_effect = "Новый тип корабля"

export(String, "dreadnought", "cruiser_of_death", "battleship_of_death") var target = "dreadnought"
	

func get_effect():
	return name_of_effect + ": " + list_of_points_of_effect[target]


func activate_effects(client):
	client.military_bonuses.list_of_fleet_units.append(target)
