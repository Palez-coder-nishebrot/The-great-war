extends ReformLevel


class_name PensionsReformLevel


@export var pensions: float = 0.0


func activate_effects(client):
	client.economy_manager.pensions += pensions


func deactivate_effects(client):
	client.economy_manager.pensions -= pensions
