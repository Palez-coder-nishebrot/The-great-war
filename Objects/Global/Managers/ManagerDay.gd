extends Node

signal allocate_workers_to_factories

var game: Object

func update_information_in_GUI():
	Players.player.information.check_GDP()
	Players.player.window_markets.update_information()
	
	Players.player.window_production.update_information()
	Players.player.window_population.update_information()
	Players.player.window_parties.update_information()
	Players.player.window_taxes.update_information()
	Players.player.buttons.update_information()
	
	GlobalMarket.clear_export_and_import()
	
	Players.player.update_point_of_reforms()


func update_economy():
	emit_signal("allocate_workers_to_factories")
	update_expenses_on_railways()
	game.craftsmen_manager.choose_good(game.time_of_game.day)
	
	game.purchase_manager.resourse_extraction(game) # Добыча ресусов населенем
	game.factory_manager.make_goods() # Производство товаров фабриками
	game.factory_manager.buy_purchase() # Купить сырье для фабрик
	meet_the_needs_of_population() # Купить товары для населения
	update_investing_in_factories()
	GlobalMarket.export_goods_from_local_markets()


func update_expenses_on_railways():
	for i in Players.list_of_players:
		i.update_expenses_on_railways()


func meet_the_needs_of_population():
	game.purchase_manager.meet_the_needs_of_poor_and_middle_classes()
	game.purchase_manager.meet_the_needs_of_rich_class()


func update_investing_in_factories():
	for i in Players.list_of_players:
		i.capitalists_manager.invest_in_factories()


func update_accounting():
	for i in Players.list_of_players:
		for y in i.accounting:
			i.accounting[y] = 0
		i.capitalists_manager.income = 0


func population_pays_taxes():
	for i in Players.list_of_players:
		i.capitalists_manager.new_day()
		for tile in i.list_of_tiles:
			Functions.pay_taxes(i, tile.population_manager, 0, "Налоги_на_бедных")


func update_clients():
	for i in Players.list_of_players:
		i.quantity_of_unemployed = 0
		i.gdp = 0
		i.radio_net = 0
		i.update_population_growth()
		i.update_welfare_of_population()
		i.update_stability()
		check_school_funding(i)
		game.craftsmen_manager.goods_production(i)
		game.population_manager.set_social_migration(i)
		
		for tile in i.list_of_tiles:
			i.quantity_of_unemployed += tile.population_manager.quantity_of_unemployed
	

func check_school_funding(player):
	var economy = player.economy
	var accounting = player.accounting
	var list_of_soc_classes = player.list_of_soc_classes
	
	var cost = economy["Образование"] * list_of_soc_classes.size()
	var bonus = Reforms.bonus_of_education[economy["Образование"]]
	
	player.budget = player.budget - cost
	accounting["Образование"] = cost
	
	player.researching_points += bonus * list_of_soc_classes.size()
	if player.researching_points >= 200:
		 increase_literate_population(player)


func increase_literate_population(player):
	for i in player.list_of_tiles:
		for soc_class in i.population_manager.list_of_soc_classes:
			if soc_class.education == false: 
				soc_class.education = true
				player.researching_points = 0
				soc_class.population_manager.list_of_households_with_education.append(soc_class)
				return
