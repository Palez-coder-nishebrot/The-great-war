extends Node

class_name EconomyManager

signal reduce_money(value)

const max_investment_pool: float = 10000.0

var DP_list:        Array = []
var factories_list: Array = []

var local_market:          Dictionary     = {}
var prices_goods:          Dictionary     = {}
var export_goods:          Dictionary     = {}
var import_goods:          Dictionary     = {}
var demand_supply_goods:   Dictionary     = {}

var factory_cost_modifier:        float = 1.0 # Это число мы будем умножать, а не прибавлять
var min_wage_modifier:            float = 1.0 # Это число мы будем умножать, а не прибавлять
var tariffs_efficiency:           float = 1.0 # Это число мы будем прибавлять, а не умножать
var taxes_efficiency:             float = 1.0 # Это число мы будем прибавлять, а не умножать

var education_cost:       float = 0.0 # Проценты
var tariffs:              float = 0.0 # Проценты
var poor_classes_taxes:   float = 0.0 # Проценты
var middle_classes_taxes: float = 0.0 # Проценты
var rich_classes_taxes:   float = 0.0 # Проценты

var pensions:             float = 0.0 # Это размер выплат. Он будет прокачиваться в реформах 
var unemployment_benefit: float = 0.0 # Это размер выплат. Он будет прокачиваться в реформах 

var max_railways:         int = 1

var gdp:                             float = 0.0
var inflation_growth:                float = 1.0

var budget:                          float = 0.0
var investment_pool:                 float = 0.0

var subsidization: bool = false
var building_np_factories: bool = false
var private_property:      bool = false

var set_accounting_values_func:  Callable
var pay_tariffs_accounting_func: Callable
var get_accounting_value_func:   Callable

var production_efficiency_manager: ProductionEfficiencyManager = ProductionEfficiencyManager.new()


var list_of_buildings: Array = [
	load("res://Resources/Factories/TipesOfFactories/AirplaneFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/AmmoFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/CanningFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/CarsFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/CharcoalFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/ClothesFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/Distillery.tres"),
	load("res://Resources/Factories/TipesOfFactories/ElectricalPartsFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/FurnitureFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/FuelFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/GlassFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/LumberPlant.tres"),
	load("res://Resources/Factories/TipesOfFactories/MechPartsFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SentheticOilFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/PhoneFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/RadioFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/RiflesFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SentheticRubberFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SaltpeterFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SentheticTextileFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SteelPlant.tres"),
	load("res://Resources/Factories/TipesOfFactories/TankFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/TextileFactory.tres"),
]


#func reduce_budget(money, expense_type):
#	budget -= money
#	set_accounting_values_func.call(expense_type)


func sort_countries_sellers_list(good, client):
	var list = Players.list_of_players.duplicate()
	list.erase(client)
	var last_el = list.size() - 1
	for j in range(4):
		for i in list:
			if list.find(i) != last_el:
				var first = i
				var second = list[list.find(i) + 1]
				
				var first_index = list.find(first)
				var second_index = list.find(second)
				
				var first_good_q = first.economy_manager.goods_for_sale[good]
				var second_good_q = second.economy_manager.goods_for_sale[good]
				
				if first_good_q < second_good_q: # Если true, то элементы меняем местами
					Functions.swap(first_index, second_index, list)
	return list


func sort_factories_list():
	var new_list = factories_list
	var last_el = new_list.size() - 1
	
	for j in range(4):
		for i in new_list:
			if new_list.find(i) != last_el:
				var first = i
				var second = new_list[new_list.find(i) + 1]
				
				var first_index = new_list.find(first)
				var second_index = new_list.find(second)
				
				var first_profit = first.based_profit
				var second_profit = second.based_profit
				
				if first_profit < second_profit: # Если true, то элементы меняем местами
					Functions.swap(first_index, second_index, new_list)


func _init():
	set_local_market()
	var _err
	_err = ManagerDay.connect("set_education_expenses", set_education_expenses)
	_err = ManagerDay.connect("update_prices", Callable(self, "update_prices"))
	_err = ManagerDay.connect("sort_factories_list", Callable(self, "sort_factories_list"))
	_err = ManagerDay.connect("buy_raw", Callable(self, "buy_raw"))
	_err = ManagerDay.connect("clear_markets", Callable(self, "clear_market"))
	_err = ManagerDay.connect("put_on_goods_on_trading", Callable(self, "put_on_goods_on_trading"))
	#var _err_ = SceneStorage.timer.connect("new_day", self, "clear_gdp")


func set_local_market():
	var path: String = "res://Resources/Good/"
	var folder: DirAccess = DirAccess.open(path)
	var _err_ = folder.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	var file = folder.get_next()
	
	while file != "":
		if file != "good.gd":
			var fle = load(path + file)
			local_market[fle] = 100.0
			prices_goods[fle] = float(fle.base_price)
			export_goods[fle] = 0.0
			import_goods[fle] = 0.0
			demand_supply_goods[fle] = [0.0, 0.0]
		file = folder.get_next()
#	breakpoint


func clear_market():
	for good in production_efficiency_manager.production_goods_efficiency:
		local_market[good] = 0.0
		export_goods[good] = 0.0
		import_goods[good] = 0.0
		demand_supply_goods[good].clear()
		demand_supply_goods[good].append(0.0)
		demand_supply_goods[good].append(0.0)


#func set_enterprises_efficiency():
#	for i in SceneStorage.regions_manager.regions_list:
#		i.set_enterprises_efficiency(self)


func buy_raw():
	for i in factories_list:
		i.buy_raw()


func set_education_expenses():
	var pop_q = get_accounting_value_func.call("population_quantity")
	var teachers_q = pop_q * 0.001
	var expenses = teachers_q * education_cost
	budget -= expenses
	set_accounting_values_func.call("education_expenses", expenses)


func update_prices():
	for good in local_market:
		var price_good = prices_goods[good]
		var demand = demand_supply_goods[good][0] #67 max_price = 8.35
		var supply = demand_supply_goods[good][1] #100
		var supply_on_glob_m = GlobalMarket.goods_quantity[good]
		
		if abs(supply - demand) > 2:
			if demand < supply and price_good > good.min_price:
				if supply_on_glob_m > 2:
					prices_goods[good] -= 0.02
			elif demand > supply and price_good < good.max_price:
				prices_goods[good] += 0.02
			
		else:
			if good.base_price > price_good:
				prices_goods[good] += 0.02
			elif good.base_price < price_good:
				prices_goods[good] -= 0.02
		prices_goods[good] = snappedf(prices_goods[good], 0.01)


func add_money_in_investment_pool(money):
	investment_pool += money
	
	if investment_pool > max_investment_pool:
		var balance = investment_pool - max_investment_pool
		investment_pool = max_investment_pool
		return balance
	return 0.0


func set_tax(value: float, variable: String):
	set(variable, value)


func pay_tariffs(money):
	budget += money
	pay_tariffs_accounting_func.call(money)


func get_enterprise_efficiency_production(enterprise):
	if enterprise.get_class() == "DP":
		return production_efficiency_manager.production_dp_efficiency
	else:
		return production_efficiency_manager.get_production_factories_efficiency()


func get_good_production_efficiency(good):
	return production_efficiency_manager.production_goods_efficiency[good]
