extends TechnologyEffect

class_name TechnologyEffectDefense

export(String) var name_of_effect = "Оборона"

export(int) var power = 0

export(String, "infantry", "artillery", "cavalry", "stormtroopers", "armored_car", "tank",
	"combat_airplane", "fighter_airplane", "bomber_airplane", "fleet") var target = "infantry"
	

func get_effect():
	return name_of_effect + " " + list_of_points_of_effect[target] + ": +" + str(power)


func activate_effects(client):
	client.military_bonuses.get(target).defense += power
