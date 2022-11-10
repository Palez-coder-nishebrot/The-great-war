extends TechnologyEffect

class_name TechnologyEffectNewFactory

export(String) var name_of_effect = "Новый тип завода"

export(String, "Rubber_factory", "Oil_factory", "Senthetic_textile_factory") var target = "Rubber_factory"


#const list_of_factories: Dictionary = {
#	"Rubber_factory": {
#		"Кроны":           150,
#		"Сталь":           2,
#	}, 
#	"Oil_factory": {
#		"Кроны":           150,
#		"Сталь":           2,
#	},
#}


func get_effect():
	return name_of_effect + ": " + list_of_points_of_effect[target]


func activate_effects(client):
	client.economic_bonuses.list_of_buildings.append(target)
