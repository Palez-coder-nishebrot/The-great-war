extends TechnologyEffect

class_name TechnologyEffectMaxInfrastructure

@export var name_of_effect: String = "Максимум инфраструктуры"

@export var target = "max_railways" # (String, "max_railways", "max_infrastructure")

@export var value: int = 1


func get_effect():
	return "Максимальный уровень " + list_of_points_of_effect[target] + ": +" + str(value)


func activate_effects(client):
	client.economic_bonuses.set(target, client.economic_bonuses.get(target) + 1)
