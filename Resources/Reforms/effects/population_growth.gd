extends ReformEffect

class_name ReformEffectPopulationGrowth

@export var effect_name: String = "population_growth"

func _init():
	target = "population_growth"


func activate_effects(client):
	client.population_manager.population_growth += value


func deactivate_effects(client):
	client.population_manager.population_growth -= value
