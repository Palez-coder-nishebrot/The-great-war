extends PartyIssue

@export var factory_cost: int = 0
@export var infrastructure_cost: int = 0
@export var taxes_efficiency:  float = 0.0

@export var subsidization: bool = true
@export var building_np_factories: bool = true
@export var private_property: bool = true


func set_values(economy_manager):
	economy_manager.subsidization         = subsidization
	economy_manager.building_np_factories = building_np_factories
	economy_manager.private_property      = private_property
	economy_manager.taxes_efficiency      = taxes_efficiency
