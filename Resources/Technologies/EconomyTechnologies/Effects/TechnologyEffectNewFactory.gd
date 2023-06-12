extends TechnologyEffect

class_name TechnologyEffectNewFactory

@export var name_of_effect: String = "Новый тип завода"

@export var target = "Rubber_factory" # (String, "Rubber_factory", "Oil_factory", "Senthetic_textile_factory")


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
