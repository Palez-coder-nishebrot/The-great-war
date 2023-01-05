extends Resource

export(String, "free_economy", "interventionism", "state_capitalism", "planned_economy") var name_of_policy = "free_economy"

export(int) var cost_of_factories = 0
export(int) var cost_of_infrastructure = 0

export(bool) var subsidization = true
export(bool) var building_not_profit_factories = true

export(int) var income_of_capitalists = 0
