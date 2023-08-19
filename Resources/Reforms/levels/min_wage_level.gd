extends ReformLevel


class_name MinWageReformLevel


@export var min_wage: float = 0.0


func activate_effects(client):
	client.economy_manager.min_wage_modifier += min_wage


func deactivate_effects(client):
	client.economy_manager.min_wage_modifier -= min_wage
