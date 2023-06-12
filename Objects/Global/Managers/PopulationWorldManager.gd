extends Node

class_name PopulationWorldManager

const INTEREST_ON_DEPOSITS: float = 1.05 #Проценты по вкладам

var population_units_list = []

func register_population_unit(population_unit):
	population_units_list.append(population_unit)
	pass


func meet_needs():
#	var grain_good = load("res://Resources/Good/grain.tres")
	for pop_unit in population_units_list:
		if pop_unit.quantity != 0:
			var region       = pop_unit.region
			var client       = region.player
			var local_market = client.economy_manager.local_market
			var prices       = client.economy_manager.prices_goods
			var demand_supply_goods = client.economy_manager.demand_supply_goods
			var pop_unit_quantity = pop_unit.quantity
			var money = pop_unit.money
			pop_unit.welfare = 0
			
			for need_good in pop_unit.population_type.needs:
				var good                 = need_good.good_type
				var int_good             = need_good.interchangeable_good #Взаимозаменяемый товар
				
				var market_good_quantity = local_market[good]
				var market_int_good_quantity = local_market[int_good]
				var needed_good_quantity = need_good.quantity * pop_unit_quantity
				var int_good_quantity = need_good.int_good_quantity * pop_unit_quantity
				
				var price                = prices[good] * needed_good_quantity
				var price_int            = prices[int_good] * int_good_quantity
				
				if money >= price:
					demand_supply_goods[good][0] += needed_good_quantity
					
					if market_good_quantity >= needed_good_quantity:
						var _expenses = Functions.buy_good_on_local_market(pop_unit, good, needed_good_quantity, client.economy_manager)
						pop_unit.welfare += 2
					else:
						buy_int_good(demand_supply_goods, int_good, price_int, int_good_quantity, market_int_good_quantity, client, pop_unit, money)
						break
				
				else:
					buy_int_good(demand_supply_goods, int_good, price_int, int_good_quantity, market_int_good_quantity, client, pop_unit, money)
					break
	
#			var percent = (pop_unit.money * INTEREST_ON_DEPOSITS) - pop_unit.money
#			client.state_bank_money -= percent
#			pop_unit.money += percent


func buy_int_good(demand_supply_goods, int_good, price_int, int_good_quantity, market_int_good_quantity, client, pop_unit, money):
	var grain_good = load("res://Resources/Good/grain.tres")
	
	if money >= price_int:
		if int_good != grain_good:
			demand_supply_goods[int_good][0] += int_good_quantity
		
		if market_int_good_quantity >= int_good_quantity:
			var _expenses = Functions.buy_good_on_local_market(pop_unit, int_good, int_good_quantity, client.economy_manager)
			pop_unit.welfare += 1


func set_population_incomes():
	for client in Players.list_of_players:
		var ec_manager = client.economy_manager
		var poor_tax   = client.economy_manager.poor_classes_taxes
		#var middle_tax = client.economy_manager.middle_classes_taxes
		#var rich_tax   = client.economy_manager.rich_classes_taxes
		
		var poor_taxes_income = 0
		
		for enterprise in ec_manager.DP_list + ec_manager.factories_list:
			enterprise.set_wage()
			var wage = enterprise.wage * enterprise.workers_unit.quantity
			var tax = get_tax(wage, poor_tax)
			var wage_tax = wage - tax
			enterprise.workers_unit.money += wage_tax
			enterprise.workers_unit.income = wage_tax
			enterprise.expenses_workers = wage
			enterprise.money -= wage
			
			poor_taxes_income += tax
		
		client.economy_manager.budget += poor_taxes_income
		client.accounting_manager.poor_class_taxes = poor_taxes_income


func get_tax(value, proc):
	return value * proc
