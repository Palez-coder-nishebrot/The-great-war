extends TechnologyEffect

class_name TechnologyEffectSupply

@export var name_of_effect: String = "Потребление"

@export var power: int = 0

@export var target = "ammo_supply" # (String, "projectile_supply", "ammo_supply")


func get_effect():
	return name_of_effect + " " + list_of_points_of_effect[target] + ": +" + str(power)


func activate_effects(client):
	client.military_bonuses.set(target, client.military_bonuses.get(target) + 1)
