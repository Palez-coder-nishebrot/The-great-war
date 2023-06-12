extends Node

class_name EconomyManager

signal reduce_money(value)

var DP_list:        Array = []
var factories_list: Array = []

var local_market:          Dictionary     = {}
var prices_goods:          Dictionary     = {}
var export_goods:          Dictionary     = {}
var import_goods:          Dictionary     = {}
var production_goods:      Dictionary     = {}
var demand_supply_goods:   Dictionary     = {}

var factory_cost:        int = 0
var min_salary_bonus:    float = 1.0 # Это число мы будем умножать, а не прибавлять!
var max_working_day:     int = 0

var poor_classes_taxes:   float = 0.0 # Проценты
var middle_classes_taxes: float = 0.0 # Проценты
var rich_classes_taxes:   float = 0.0 # Проценты

var pensions:             int = 0
var unemployment_benefit: int = 0
var healthcare:           int = 0

var max_railways:         int = 1

var gdp:                             float = 0.0
var inflation_growth:                float = 1.0
var factories_efficiency_production: float = 0.0
var DP_efficiency_production:        float = 0.0

var budget:                          float = 0.0

var set_accounting_values_func: Callable

var factory_efficiency_production: Dictionary = {
	load("res://Resources/Factories/TipesOfFactories/AirplaneFactory.tres"):        0.0,
	load("res://Resources/Factories/TipesOfFactories/AmmoFactory.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/CanningFactory.tres"):         0.0,
	load("res://Resources/Factories/TipesOfFactories/CarsFactory.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/CharcoalFactory.tres"):        0.0,
	load("res://Resources/Factories/TipesOfFactories/ClothesFactory.tres"):         0.0,
	load("res://Resources/Factories/TipesOfFactories/Distillery.tres"):             0.0,
	load("res://Resources/Factories/TipesOfFactories/ElectricalPartsFactory.tres"): 0.0,
	load("res://Resources/Factories/TipesOfFactories/FurnitureFactory.tres"):       0.0,
	load("res://Resources/Factories/TipesOfFactories/FuelFactory.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/GlassFactory.tres"):           0.0,
	load("res://Resources/Factories/TipesOfFactories/LumberPlant.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/MechPartsFactory.tres"):       0.0,
	load("res://Resources/Factories/TipesOfFactories/SentheticOilFactory.tres"):    0.0,
	load("res://Resources/Factories/TipesOfFactories/PhoneFactory.tres"):           0.0,
	load("res://Resources/Factories/TipesOfFactories/RadioFactory.tres"):           0.0,
	load("res://Resources/Factories/TipesOfFactories/RiflesFactory.tres"):          0.0,
	load("res://Resources/Factories/TipesOfFactories/SentheticRubberFactory.tres"): 0.0,
	load("res://Resources/Factories/TipesOfFactories/SaltpeterFactory.tres"):       0.0,
	load("res://Resources/Factories/TipesOfFactories/SentheticTextileFactory.tres"):0.0,
	load("res://Resources/Factories/TipesOfFactories/SteelPlant.tres"):             0.0,
	load("res://Resources/Factories/TipesOfFactories/TankFactory.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/TextileFactory.tres"):         0.0,
}

var goods_efficiency_production: Dictionary = {
	load("res://Resources/Good/alcohol.tres"):0.0,
	load("res://Resources/Good/ammo.tres"):0.0,
	load("res://Resources/Good/artillery.tres"):0.0,
	load("res://Resources/Good/beasts.tres"):0.0,
	load("res://Resources/Good/canned_food.tres"):0.0,
	load("res://Resources/Good/cars.tres"):0.0,
	load("res://Resources/Good/clothes.tres"):0.0,
	load("res://Resources/Good/coal.tres"):0.0,
	load("res://Resources/Good/cotton.tres"):0.0,
	load("res://Resources/Good/el_parts.tres"):0.0,
	load("res://Resources/Good/furniture.tres"):0.0,
	load("res://Resources/Good/gas.tres"):0.0,
	load("res://Resources/Good/glass.tres"):0.0,
	load("res://Resources/Good/grain.tres"):0.0,
	load("res://Resources/Good/iron.tres"):0.0,
	load("res://Resources/Good/lumber.tres"):0.0,
	load("res://Resources/Good/mech_parts.tres"):0.0,
	load("res://Resources/Good/oil.tres"):0.0,
	load("res://Resources/Good/phone.tres"):0.0,
	load("res://Resources/Good/radio.tres"):0.0,
	load("res://Resources/Good/rifles.tres"):0.0,
	load("res://Resources/Good/rubber.tres"):0.0,
	load("res://Resources/Good/saltpeter.tres"):0.0,
	load("res://Resources/Good/steel.tres"):0.0,
	load("res://Resources/Good/tanks.tres"):0.0,
	load("res://Resources/Good/textile.tres"):0.0,
	load("res://Resources/Good/wood.tres"):0.0,
}

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
	set_list_of_buildings()
	var _err
	_err = ManagerDay.connect("update_prices", Callable(self, "update_prices"))
	_err = ManagerDay.connect("set_gdp", Callable(self, "set_gdp"))
	_err = ManagerDay.connect("sort_factories_list", Callable(self, "sort_factories_list"))
	_err = ManagerDay.connect("buy_raw", Callable(self, "buy_raw"))
	_err = ManagerDay.connect("clear_markets", Callable(self, "clear_market"))
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
			production_goods[fle] = 0.0
			demand_supply_goods[fle] = [0.0, 0.0]
		
		file = folder.get_next()
#	breakpoint


func clear_market():
	for good in goods_efficiency_production:
		local_market[good] = 0.0
		export_goods[good] = 0.0
		import_goods[good] = 0.0
		production_goods[good] = 0.0
		demand_supply_goods[good].clear()
		demand_supply_goods[good].append(0.0)
		demand_supply_goods[good].append(0.0)


func set_list_of_buildings():
	var list = []
	for file in list_of_buildings:
		var factory = SceneStorage.regions_manager.province_loader.generate_factory(file)
		ManagerDay.disconnect("produce_goods", Callable(factory, "produce_goods"))
		ManagerDay.disconnect("set_based_profit", Callable(factory, "set_based_profit"))
		list.append(factory)
	list_of_buildings = list


func set_enterprises_efficiency():
	for i in SceneStorage.regions_manager.regions_list:
		i.set_enterprises_efficiency(self)


func set_gdp():
	var value = 0
	for i in DP_list + factories_list:
		value += i.income
	#set_accounting_values_func.call("gdp", value)


func buy_raw():
	for i in factories_list:
		i.buy_raw()


func check_factories_bankrupt():
	for factory in factories_list:
		var subsidization_expenses = factory.check_bankrupt()
		budget -= subsidization_expenses
		set_accounting_values_func.call("subsidies_expenses", subsidization_expenses)


func update_prices():
	for good in local_market:
		var price_good = prices_goods[good]
		var demand = demand_supply_goods[good][0] #67 max_price = 8.35
		var supply = demand_supply_goods[good][1] #100
		
		if supply != 0:
			var border_price = (demand / supply) * good.base_price
			
			if border_price < good.base_price and price_good > border_price:
				prices_goods[good] -= 0.02
			elif border_price > good.base_price and price_good < border_price:
				prices_goods[good] += 0.02
		
		elif demand > 0 and price_good < good.max_price:
			prices_goods[good] += 0.05
		prices_goods[good] = snappedf(prices_goods[good], 0.01)


func set_tax(value: float, variable: String):
	set(variable, value)


func get_DP_efficiency_production():
	return DP_efficiency_production


func get_factories_efficiency_production():
	return factories_efficiency_production


func get_factory_types_efficiency_production(factory_type):
	return factory_efficiency_production[factory_type]


func get_good_production_efficiency(good):
	return goods_efficiency_production[good]


func get_factories_list():
	return factories_list
