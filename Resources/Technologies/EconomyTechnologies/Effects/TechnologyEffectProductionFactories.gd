extends TechnologyEffect

class_name TechnologyEffectProductionFactories

@export var name_of_effect: String = "Производительность заводов"

@export var power: float = 0.0

func get_effect():
	var bonus = power * 100.0
	return name_of_effect + ": +" + str(bonus)  + "%"


func activate_effects(client):
	client.economy_manager.production_efficiency_manager.production_factories_efficiency += power
