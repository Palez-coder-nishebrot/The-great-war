extends TechnologyEffect

class_name TechnologyEffectNewUnit

export(String) var name_of_effect = "Новый юнит"

export(String, "stormtroopers", "tank", "fighter_airplane", 
	"bomber_airplane") var target = "armored_car"
	

func get_effect():
	return name_of_effect + ": " + list_of_points_of_effect[target]


func activate_effects(client):
	client.military_bonuses.list_of_units.append(target)
