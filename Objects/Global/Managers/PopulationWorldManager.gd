extends Node

class_name PopulationWorldManager

signal clear_income_variable

const INTEREST_ON_DEPOSITS: float = 1.05 #Проценты по вкладам
const POP_COEF:             float = 0.001 #Умножается на количество сырья, потреб. товаров, произв. труда и тд...

var population_units_list = []


func register_population_unit(population_unit):
	population_units_list.append(population_unit)


func meet_needs():
#	var grain_good = load("res://Resources/Good/grain.tres")
	for pop_unit in population_units_list:
		if pop_unit.quantity != 0:
			pop_unit.expenses = 0.0
			var region       = pop_unit.region
			var client       = region.player
			var local_market = client.economy_manager.local_market
			var prices       = client.economy_manager.prices_goods
			var demand_supply_goods = client.economy_manager.demand_supply_goods
			var pop_unit_quantity = pop_unit.quantity
			var economy_manager = client.economy_manager
			var tariffs            = economy_manager.tariffs
			var tariffs_efficiency = economy_manager.tariffs_efficiency
			
			pop_unit.welfare = 0
			for need_good in pop_unit.population_type.needs:
				var money                = pop_unit.money
				var good                 = need_good.good_type
				
#				if pop_unit.population_type == load("res://Resources/population_types/clerk.tres"):
#					breakpoint
				
				var market_good_quantity = local_market[good]
				var needed_good_quantity = need_good.get_good_quantity() * pop_unit_quantity
				
				var price                = prices[good] * needed_good_quantity
				
				if market_good_quantity > needed_good_quantity or is_equal_approx(market_good_quantity, needed_good_quantity):
					if pop_unit.money >= price:
						demand_supply_goods[good][0] += needed_good_quantity
						pop_unit.expenses += Functions.buy_good_on_local_market(pop_unit, good, needed_good_quantity, economy_manager)
						pop_unit.welfare += 1
				else:
					var im_good_quantity = needed_good_quantity - market_good_quantity
					var new_price = Functions.get_good_price(price, im_good_quantity, market_good_quantity, tariffs, tariffs_efficiency)
					var is_buying_valid = GlobalMarket.check_goods_quantity(good, im_good_quantity)
					
					if im_good_quantity < 0:
						breakpoint
					
					if money > new_price or is_equal_approx(money, new_price):
						demand_supply_goods[good][0] += needed_good_quantity
						if is_buying_valid:
							GlobalMarket.fill_lack(economy_manager, good, im_good_quantity)
							pop_unit.expenses += Functions.buy_good_on_local_market(pop_unit, good, needed_good_quantity, economy_manager, im_good_quantity)
							pop_unit.welfare += 1
						else:
							break


func set_population_incomes():
	emit_signal("clear_income_variable")
	for client in Players.list_of_players:
		var ec_manager = client.economy_manager
		var taxes_efficiency = ec_manager.taxes_efficiency
		var poor_tax   = client.economy_manager.poor_classes_taxes
		var middle_tax = client.economy_manager.middle_classes_taxes
		
		if poor_tax > 0:
			poor_tax = poor_tax + taxes_efficiency
		
		if middle_tax > 0:
			middle_tax = middle_tax + taxes_efficiency
		
		var poor_taxes_income = 0
		var middle_taxes_income = 0
		
		for enterprise in ec_manager.DP_list + ec_manager.factories_list:
			if not enterprise.closed:
				enterprise.set_wage()
				
				poor_taxes_income += pay_wage_to_workers(enterprise, poor_tax)
				
				if enterprise is Factory: 
					middle_taxes_income += pay_wage_to_clerks(enterprise, middle_tax)
				
				enterprise.set_profit()
			else:
				enterprise.workers_unit.income = 0.0
				if enterprise is Factory: enterprise.clerks_unit.income = 0.0
		
		client.economy_manager.budget += poor_taxes_income
		client.accounting_manager.poor_class_taxes = poor_taxes_income


func pay_wage_to_clerks(factory, middle_tax):
	var wage = factory.wage * factory.workers_quantity
	var tax = 0#get_tax(wage, middle_tax)
	var pop_unit_wage = wage - tax
	
	factory.clerks_unit.money  = pop_unit_wage
	factory.clerks_unit.income = pop_unit_wage
	
	factory.expenses_workers += wage
	factory.money -= wage
	
	return tax


func pay_wage_to_workers(enterprise, poor_tax):
	var wage = enterprise.wage * enterprise.workers_quantity
	var wage_bonus = enterprise.money_for_increase_wage / enterprise.workers_quantity
	var pop_unit_income  = wage_bonus + wage
	var tax = get_tax(pop_unit_income, poor_tax)
	var pop_unit_wage = pop_unit_income - tax
	
	enterprise.workers_unit.money  = pop_unit_wage
	enterprise.workers_unit.income += pop_unit_wage
	enterprise.expenses_workers = wage
	enterprise.money -= wage
	
	return tax


func set_population_growth():
	for region in SceneStorage.regions_manager.regions_list:
		#var pension    = 0.0
		#var healthcare = 0.0
		for pop_unit in region.population.population_types:
			var welfare = pop_unit.welfare
			var value   = 0.0
			
			if is_zero_approx(welfare):
				value = 0.0
			elif welfare > 0.0:
				value = 1.0
			elif welfare > 4.0:
				value = 2.0
			pop_unit.unemployed_quantity += value
			pop_unit.quantity            += value
			pop_unit.population_growth   = value


func get_tax(value, proc):
	return value * proc
