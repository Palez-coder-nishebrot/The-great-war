extends TechnologyEffect

class_name TechnologyEffectProductionFactories

export(String) var name_of_effect = "Производительность"

export(int) var power = 0

export(String, "military_factories", "factories", "farms", "mines") var target = "factories"


const list_of_effects: Dictionary = {
	"military_factories": "production_of_military_factories", 
	"factories": "production_of_factories", 
	"farms": "production_of_farms", 
	"mines": "production_of_mines", 
}


func get_effect():
	return name_of_effect + " " + list_of_points_of_effect[target] + ": +" + str(power)  + "%"


func activate_effects(client):
	var variable = list_of_effects[target]
	var bonus = client.economic_bonuses.get(variable) * 10
	client.economic_bonuses.set(variable, (bonus + power) / 10)
