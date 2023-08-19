extends ReformEffect

class_name ReformEffectPopulationGrowth


func _init():
	target = "population_growth"


func activate_effects(client):
	client.population_manager.pop_growth_modifier += value


func deactivate_effects(client):
	client.population_manager.pop_growth_modifier -= value
