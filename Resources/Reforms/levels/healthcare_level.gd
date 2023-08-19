extends ReformLevel


class_name HealthcareReformLevel


@export var population_growth: float = 0.0


func activate_effects(client):
	client.population_manager.pop_growth_modifier += population_growth


func deactivate_effects(client):
	client.population_manager.pop_growth_modifier -= population_growth
