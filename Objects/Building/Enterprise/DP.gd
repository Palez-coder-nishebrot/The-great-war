extends Enterprise
class_name DP


var selling_goods_quantity: float = 0.0
var workers_unit
var workers_quantity: float = 0.0

var economy_manager


func _init():
	var _err = ManagerDay.connect("produce_goods", produce_goods)


func get_DP_production_efficiency():
	return production_efficiency + good_production_efficiency + get_based_good_effiency_production()


func produce_goods():
	var prod_efficiency = get_DP_production_efficiency()
	var good_quanity = prod_efficiency * workers_unit.quantity
	
	workers_unit.income = 0
	
	sell_goods(good_quanity)


func sell_goods(quanity):
	economy_manager.demand_supply_goods[good][1] += quanity
	economy_manager.local_market[good] += quanity
	var income_ = economy_manager.prices_goods[good] * quanity

	money += income_
	income = income_
	
	selling_goods_quantity = quanity


func set_wage():
	wage = income / workers_quantity
