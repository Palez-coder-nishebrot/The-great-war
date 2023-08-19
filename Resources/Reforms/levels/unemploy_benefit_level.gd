extends ReformLevel


class_name UnemploymentBenefitReformLevel


@export var unemployment_benefit: float = 0.0


func activate_effects(client):
	client.population_manager.unemployment_benefit += unemployment_benefit


func deactivate_effects(client):
	client.population_manager.unemployment_benefit -= unemployment_benefit
