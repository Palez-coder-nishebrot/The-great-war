extends Node

signal allocate_workers_to_factories
signal clear_income_in_pop_units

var game: Object

func update_information_in_GUI():
	Players.player.information.check_GDP()
	Players.player.window_markets.update_information()
	
	Players.player.window_production.update_information()
	Players.player.window_population.update_information()
	Players.player.window_parties.update_information()
	Players.player.window_taxes.update_information()
	Players.player.buttons.update_information()
	
	#GlobalMarket.clear_export_and_import()


func update_economy():
	emit_signal("allocate_workers_to_factories")
	#update_expenses_on_railways()
	#game.craftsmen_manager.choose_good(game.time_of_game.day)
	
	game.purchase_manager.resourse_extraction(game) # Добыча ресусов населенем
	game.factory_manager.make_goods() # Производство товаров фабриками
	#game.factory_manager.buy_purchase() # Купить сырье для фабрик
	SceneStorage.population_manager.meet_needs() # Купить товары для населения
	#update_investing_in_factories()
	update_balance()
	#GlobalMarket.export_goods_from_local_markets()
	


func clear_markets():
	for client in Players.list_of_players:
		for good in client.local_market:
			client.local_market[good] = 0
			client.export_goods[good] = 0
			client.import_goods[good] = 0
			client.production_goods[good] = 0
			
			client.demand_supply_goods[good][0] = 0
			client.demand_supply_goods[good][1] = 0


func update_prices():
	for client in Players.list_of_players:
		for good in client.local_market:
			var price_good = client.prices_goods[good]
			var demand = client.demand_supply_goods[good][0]
			var supply = client.demand_supply_goods[good][1]
			
			if demand != 0:
				var q = ((supply / demand) * 100) - 100
				var price = good.base_price - (good.base_price * 0.01) * q
				
				if price > price_good and price_good < good.max_price:
					client.prices_goods[good] += 0.05
				elif price < price_good and price_good > good.min_price:
					client.prices_goods[good] -= 0.05
			
			elif supply > 0 and price_good > good.min_price:
				client.prices_goods[good] -= 0.05

func update_balance():
	for i in Players.list_of_players:
		i.update_balance()


func update_expenses_on_railways():
	for i in Players.list_of_players:
		i.update_expenses_on_railways()


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


func update_trade_agreements():
	pass


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
	
