extends ReformLevel


class_name SchoolSystemReformLevel


@export var education_efficiency: float = 0.0


func activate_effects(client):
	client.population_manager.education_efficiency += education_efficiency


func deactivate_effects(client):
	client.population_manager.education_efficiency -= education_efficiency
