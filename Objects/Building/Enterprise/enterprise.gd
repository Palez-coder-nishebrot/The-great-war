extends Node

class_name Enterprise

signal delete_produced_good(gd)
signal append_produced_good(gd)
signal update_employed_places

#export(Array) var required_product
#export(Array) var worker_limitation
#export(float) var worker_productivity = 1
#export(Resource) var product
#export(int) var money = 0
const clerks_labour_productivity:    float = 2 * PopulationWorldManager.POP_COEF
const craftsmen_labour_productivity: float = 1 * PopulationWorldManager.POP_COEF
const labourers_labour_productivity: float = 9 * 0.1 * PopulationWorldManager.POP_COEF
const max_money:                  float = 500.0

var good: Resource

var enterprise_production_efficiency: float = 0.0 #Прокачка эффективности Предприятия через технологии
var good_production_efficiency:       float = 0.0 #Прокачка эффективности пр-ва товара через технологии
var based_good_production_efficiency: float = 0.0 #Базовая эффективность пр-ва товара
var production_efficiency:            float = 0.0#:

var selling_goods_quantity:     float = 0.0

var profit:                     float = 0.0
var income:                     float = 0.0
var expenses_workers:           float = 0.0
var wage:                       float = 0.0
var money:                      float = 100.0
var money_for_increase_wage:    float = 0.0

var closed: bool = false

var economy_manager:  Object


func open_enterprise():
	closed = false
	money = 100
	economy_manager.budget -= 100
	emit_signal("append_produced_good", good)
	emit_signal("update_employed_places")


func close_enterprise():
	closed = true
	emit_signal("delete_produced_good", good)
	emit_signal("update_employed_places")
	

func add_money_in_investment_pool():
	var dop_money = 0.0
	if money > max_money and profit > 0:
		var balance = money - max_money
		money = max_money
		dop_money = economy_manager.add_money_in_investment_pool(balance)
	money_for_increase_wage = dop_money
