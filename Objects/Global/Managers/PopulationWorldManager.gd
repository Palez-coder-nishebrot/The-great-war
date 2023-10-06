extends Node

class_name PopulationWorldManager

signal clear_income_variable

const INTEREST_ON_DEPOSITS:         float = 1.05 #Проценты по вкладам
const POP_COEF:                     float = 0.001 #Умножается на количество сырья, потреб. товаров, произв. труда и тд...
const BUREAUCRATS_BUREAUCRACY_WAGE: float = 50 * POP_COEF
const BUREAUCRATS_EDUCATION_WAGE:   float = 200 * POP_COEF

var population_units_list = []


func register_population_unit(population_unit):
	population_units_list.append(population_unit)


func meet_needs():
#	var grain_good = load("res://Resources/Good/grain.tres")
	for pop_unit in population_units_list:
		if pop_unit.quantity != 0:
			pop_unit.expenses = 0.0
			
			pop_unit.welfare = 0
			pop_unit.luxury_needs_satisfied = 0
			pop_unit.usual_needs_satisfied  = 0
			for need_good in pop_unit.population_type.needs:
				meet_need(pop_unit, need_good)
			deposit_money(pop_unit)


func meet_need(pop_unit: PopulationUnit, need_good: NeededGood):
	var good                = need_good.get_good(pop_unit)
	var need_good_quantity  = need_good.get_good_quantity()
	
	var region              = pop_unit.region
	var client              = region.client_owner
	var economy_manager     = client.economy_manager
	var local_market        = client.economy_manager.local_market
	var prices              = client.economy_manager.prices_goods
	var demand_supply_goods = client.economy_manager.demand_supply_goods
	var pop_unit_quantity   = pop_unit.quantity
	var tariffs             = economy_manager.tariffs
	var tariffs_efficiency  = economy_manager.tariffs_efficiency
	var money               = pop_unit.money

	var market_good_quantity = local_market[good]
	var needed_good_quantity = need_good_quantity * pop_unit_quantity
	
	var price                = prices[good] * needed_good_quantity
	
	if market_good_quantity > needed_good_quantity or is_equal_approx(market_good_quantity, needed_good_quantity):
		if pop_unit.money >= price:
			demand_supply_goods[good][0] += needed_good_quantity
			pop_unit.expenses += Functions.buy_good_on_local_market(pop_unit, good, needed_good_quantity, economy_manager)
			pop_unit.increase_welfare(need_good)
	else:
		var im_good_quantity = needed_good_quantity - market_good_quantity
		var new_price        = Functions.get_good_price(price, im_good_quantity, market_good_quantity, tariffs, tariffs_efficiency)
		var is_buying_valid  = GlobalMarket.check_goods_quantity(good, im_good_quantity)
		
		if im_good_quantity < 0:
			breakpoint
		
		if money > new_price or is_equal_approx(money, new_price):
			demand_supply_goods[good][0] += needed_good_quantity
			if is_buying_valid:
				GlobalMarket.fill_lack(economy_manager, good, im_good_quantity)
				pop_unit.expenses += Functions.buy_good_on_local_market(pop_unit, good, needed_good_quantity, economy_manager, im_good_quantity)
				pop_unit.increase_welfare(need_good)


func deposit_money(pop_unit):
	var client     = pop_unit.region.client_owner
	var ec_manager = client.economy_manager
	
	ec_manager.investment_pool += pop_unit.money


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
			enterprise.expenses_workers = 0
			if not enterprise.closed:
				enterprise.set_wage()
				
				poor_taxes_income += pay_wage(enterprise, client, enterprise.workers_unit, "workers_quantity", "wage")
				
				if enterprise is Factory: 
					middle_taxes_income += pay_wage(enterprise, client, enterprise.clerks_unit, "clerks_quantity", "clerks_wage")
				
				enterprise.set_profit()
		
		for region in client.regions_list:
			var bureaucrats = region.population.population_types[3]
			pay_bureaucrats_wage(bureaucrats, client)
		
		client.economy_manager.budget               += poor_taxes_income + middle_taxes_income
		client.accounting_manager.poor_class_taxes   = poor_taxes_income
		client.accounting_manager.middle_class_taxes = middle_taxes_income
		


func pay_wage(enterprise: Enterprise, client: Client, pop_unit: PopulationUnit, workers_q_var: String, wage_var: String):
	var wage = enterprise.get(workers_q_var) * enterprise.get(wage_var)
	var tax = client.economy_manager.get(pop_unit.population_type.tax_variable)
	var pop_unit_wage = wage - tax
	
	pop_unit.money  = pop_unit_wage
	pop_unit.income = pop_unit_wage
	
	enterprise.expenses_workers  += wage
	enterprise.money            -= wage
	
	return tax * wage


func pay_bureaucrats_wage(pop_unit: PopulationUnit, client: Client):
	var func_1 = (client.economy_manager.bureaucracy_cost * BUREAUCRATS_BUREAUCRACY_WAGE) * pop_unit.quantity
	var func_2 = (client.economy_manager.education_cost   * BUREAUCRATS_EDUCATION_WAGE)   * pop_unit.quantity
	var wage = func_1 + func_2
	
	pop_unit.money  = wage
	pop_unit.income = wage
	
	client.economy_manager.budget -= wage


func get_tax(value, proc):
	return value * proc
