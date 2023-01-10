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


func update_economy():
	emit_signal("allocate_workers_to_factories")
	update_expenses_on_railways()
	#game.craftsmen_manager.choose_good(game.time_of_game.day)
	
	game.purchase_manager.resourse_extraction(game) # Добыча ресусов населенем
	game.factory_manager.make_goods() # Производство товаров фабриками
	game.factory_manager.buy_purchase() # Купить сырье для фабрик
	meet_the_needs_of_population() # Купить товары для населения
	update_investing_in_factories()
	update_balance()
	GlobalMarket.export_goods_from_local_markets()


#func update_soc_migration():
#	for i in Players.list_of_players:
#		i.population_manager.new_day(i, game.time_of_game)


func update_balance():
	for i in Players.list_of_players:
		i.update_balance()


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
			Functions.pay_taxes(i, tile.population_manager, 0, "tax_on_poor_class")


func update_clients():
	for i in Players.list_of_players:
		i.quantity_of_unemployed = 0
		i.gdp = 0
		i.radio_net = 0
		i.population_manager.update_quantity_of_population()
		i.population_manager.update_population_growth()
		i.update_values_of_population()
		i.parties_manager.update_popularity_of_parties()
		i.reforms_manager.check_data(game.time_of_game)
		#i.technologies.update_middle_value_education_of_population()
		i.reforms_manager.update_points_of_reforms()
		
#		i.population_manager.update_soc_migration()
		i.population_manager.update_research_points()
		i.population_manager.update_expenses_education()
		#game.craftsmen_manager.goods_production(i)
		#game.population_manager.set_social_migration(i)
		
		for tile in i.list_of_tiles:
			i.quantity_of_unemployed += tile.population_manager.quantity_of_unemployed
	
