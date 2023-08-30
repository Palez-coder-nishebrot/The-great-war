extends PartyIssue

class_name TradeIssue

@export var tariffs_efficiency: float = 1.0
@export var investing:          bool


func set_values(economy_manager):
	economy_manager.tariffs_efficiency = tariffs_efficiency
