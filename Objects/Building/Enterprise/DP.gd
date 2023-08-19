extends Enterprise
class_name DP


var workers_unit
var workers_quantity: float = 0.0


func _init(good_, economy_manager_):
	var _err = ManagerDay.connect("produce_goods", produce_goods)
	_err = ManagerDay.connect("add_money_in_investment_pool", add_money_in_investment_pool)
	good = good_
	economy_manager = economy_manager_
	#production_efficiency = 2
	#print(production_efficiency)


func produce_goods():
	var workers_productivity = workers_quantity * labourers_labour_productivity
	var good_quanity         = snappedf(production_efficiency * workers_productivity, 0.1)
	
	workers_unit.income = 0
	
	sell_goods(snappedf(good_quanity, 0.1))


func sell_goods(quanity):
	economy_manager.demand_supply_goods[good][1] += quanity
	economy_manager.local_market[good] += quanity
	
	var income_ = economy_manager.prices_goods[good] * quanity

	money += income_
	income = income_
	
	selling_goods_quantity = quanity


func set_wage():
	wage = (income / workers_quantity) + (money_for_increase_wage / workers_quantity)


func set_profit():
	profit = income - expenses_workers
