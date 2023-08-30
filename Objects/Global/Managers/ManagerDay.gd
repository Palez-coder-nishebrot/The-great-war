extends Node

signal allocate_workers_to_DP
signal allocate_workers_to_factories

signal update_internal_migration
signal add_money_in_investment_pool
signal check_projects
signal put_on_goods_on_trading
signal set_accounting
signal sort_factories_list
signal set_based_profit
signal produce_goods
signal buy_raw
signal update_prices # EconomyManager
signal set_factories_subsidies
signal set_education_expenses

signal clear_markets
signal clear_accounting 

var game: Object

func update_information_in_GUI():
	var player = Players.get_player()
	player.information.update_info()
	player.window_markets.update_information()
	
	player.window_reform.update_information()
	player.window_production.update_information()
	player.window_population.update_information()
	player.window_parties.update_information()
	player.window_taxes.update_information()
	player.buttons.update_information()


func update_economy():
	emit_signal("check_projects")
	emit_signal("allocate_workers_to_DP")
	emit_signal("allocate_workers_to_factories")
	emit_signal("produce_goods")
	emit_signal("set_based_profit")
	emit_signal("sort_factories_list")
	emit_signal("buy_raw")
	emit_signal("set_factories_subsidies")
	emit_signal("set_education_expenses")
	emit_signal("add_money_in_investment_pool")#Дает прибавку к ЗП
	SceneStorage.population_manager.set_population_incomes()
	SceneStorage.population_manager.meet_needs()#Купить товары для населения
	emit_signal("update_prices")
	emit_signal("set_accounting")
	GlobalMarket.set_exporting_goods()
