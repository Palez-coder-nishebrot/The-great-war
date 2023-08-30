extends TechnologyEffect

class_name TechnologyEffectNewFactory

@export var name_of_effect: String = "Сооружение"

@export var target: FactoryTipe



func get_effect():
	return name_of_effect + ": " + tr(target.name_of_factory)


func activate_effects(client):
	client.economic_bonuses.list_of_buildings.append(target)
