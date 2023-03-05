extends Node

var list_of_factories: Array = []

var min_salary: int = 2


func make_goods():
	for factory in list_of_factories:
		if factory.closed == false:
		
			var good = factory.good
			var quanity = factory.get_good_quantity()
			factory.good_production = quanity
	
			make_good(factory, good, quanity)


func make_good(factory, good, quanity):
	var player = factory.province.player
	var price = player.prices_goods[good] * quanity
	
	player.local_market[good] += quanity
	player.demand_supply_goods[good][1] += quanity
	
	factory.money += price
	factory.income = price
	Functions.change_GDP(good, quanity, factory.province.player)


func buy_purchase():
	for factory in list_of_factories:
		if factory.closed == false:
			
			factory.buy_based_goods()
			
#			var good = factory.good
			var purchase = factory.purchase
			var quantity_of_workers = factory.quantity_of_workers
			var province = factory.province
			var expenses = factory.money
			var local_market = factory.province.player.local_market
			
			var expenses_purchase_gl_mt = 0
			var expenses_purchase_ll_mt = 0
			
			for resourse in purchase:
				var quanity_of_good = purchase[resourse] * quantity_of_workers
				if Functions.check_good_on_local_market(resourse, quanity_of_good, local_market):
					expenses_purchase_ll_mt += Functions.buy_good_on_local_market(factory, resourse, quanity_of_good, local_market)
					
					
				else:
					expenses_purchase_gl_mt += Functions.buy_good_on_global_market(resourse, quanity_of_good, province.player)
					factory.money -= Functions.buy_good_on_global_market(resourse, quanity_of_good, province.player)
					
					
			var salary = pay_salary(quantity_of_workers, province, factory)
			factory.expenses_purchase = expenses_purchase_gl_mt + expenses_purchase_ll_mt
			factory.expenses_workers = salary
			check_bankrupt(factory, province)
			check_income(factory, expenses)
			

func check_income(factory, _expenses):
	#factory.province.player.capitalists_manager.income += factory.income
	var income_of_capitalist = (float(factory.income) / 100.0) * factory.province.player.income_of_capitalists
	var income_of_country = factory.income - income_of_capitalist
	factory.province.player.capitalists_manager.income += income_of_capitalist
	
	factory.province.player.accounting["Производство"] += income_of_country
	factory.province.player.money_of_state_bank += income_of_country
	factory.province.player.capitalists_manager.money += income_of_capitalist
	factory.update_places_for_workers()
	
	
func check_bankrupt(factory, province):
	if factory.money <= 0:
		if factory.subsidization == true:
			var subs = (170 - factory.money)
			set_accounting_of_subsidization(factory, province.player, subs)
		
		else:
			factory.bankrupt()
	
	if factory.money >= 500:
		factory.money = 500


func set_accounting_of_subsidization(factory, player, subs):
	player.budget -= subs
	player.accounting["Субсидии"] += subs
	factory.money = 170


func start_expansion_of_factory(factory, province):
	var expansion_object = load("res://Objects/Building/Expand_factory.gd").new()
	expansion_object.building = factory
	expansion_object.game = province.player.get_parent()
	expansion_object.start_expansion_of_factory()
	
	factory.expansion = expansion_object


func pay_salary(workers_quantity, province, factory):
	var client = province.player
	var pop_unit = province.population.population_types[1]
	
	var salary = (min_salary + factory.province.player.min_salary) * workers_quantity
	pop_unit.money += salary
	client.population_manager.income += salary
	factory.money -= salary
	Functions.pay_income_taxes(client, pop_unit, client.tax_on_poor_class, salary)
	return salary
