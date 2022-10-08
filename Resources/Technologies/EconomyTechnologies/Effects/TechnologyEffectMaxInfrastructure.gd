extends TechnologyEffect

class_name TechnologyEffectMaxInfrastructure

export(String) var name_of_effect = "Максимум инфраструктуры"

export(String, "max_railways", "max_infrastructure") var target = "max_railways"


func get_effect():
	return "Максимальный уровень " + list_of_points_of_effect[target] + ": +1"


func activate_effects(client):
	client.economic_bonuses.set(target, client.economic_bonuses.get(target) + 1)
