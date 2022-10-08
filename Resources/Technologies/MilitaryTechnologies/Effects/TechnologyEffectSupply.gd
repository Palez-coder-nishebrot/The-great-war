extends TechnologyEffect

class_name TechnologyEffectSupply

export(String) var name_of_effect = "Потребление"

export(int) var power = 0

export(String, "projectile_supply", "ammo_supply") var target = "ammo_supply"


func get_effect():
	return name_of_effect + " " + list_of_points_of_effect[target] + ": +" + str(power)


func activate_effects(client):
	client.military_bonuses.set(target, client.military_bonuses.get(target) + 1)
