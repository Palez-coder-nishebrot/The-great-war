extends Enterprise
#var good: Resource
#var production_efficiency: float
#var good_production_efficiency: float
class_name Factory

var type_production_efficiency: float = 0.0

const min_salary: int = 2
const quantity_of_based_goods: float  = 0.025
const time:              int          = 10
var time_of_construction:int          = 0

var based_profit:        float        = 0.0 # Прибыль, когда на заводе работает 1 рабочий
var good_production:     float        = 0.0
var expenses_raw:        int          = 0
var expenses_factory_equipment: int   = 0
var real_max_employed_number:   int   = 10
var max_employed_number: int          = 10
var workers_quantity:    float        = 0.0

var ready_to_produce:    bool         = true
var subsidization:       bool         = false
var closed:              bool         = true
var in_construction:     bool         = false

var type_factory:      Resource
var name_of_factory:   String
#var raw:               Array
var raw_storage:       Array
var factory_equipment: Array

var province:         Object
var expansion:        Object
var economy_manager:  Object
var workers_unit:     Object


func _init():
	var _err = ManagerDay.connect("produce_goods", Callable(self, "produce_goods"))
	var __err = ManagerDay.connect("set_based_profit", Callable(self, "set_based_profit"))
	wage = 2


func produce_goods():
	if ready_to_produce == false:
		good_production = 0
		income = 0
		return
	var q = get_good_quantity(get_workers_quantity())
	var p = economy_manager.prices_goods[good]
	
	good_production = q
	economy_manager.demand_supply_goods[good][1] += q
	#print(economy_manager.demand_supply_goods[good][1], "", q)
	economy_manager.local_market[good] += q
	income = q * p
	money += income
	set_empty_raw_storage()


func set_empty_raw_storage():
	for i in raw_storage:
		i.quantity = 0


func buy_factory_equipment():
	var old_money = money
	for good_for_buy in factory_equipment:
		var quantity = quantity_of_based_goods * workers_quantity
		var local_market = economy_manager.local_market
		economy_manager.demand_supply_goods[good][0] += quantity
		
		if local_market[good_for_buy] >= quantity:
			Functions.buy_good_on_local_market(self, good_for_buy, quantity, economy_manager)
		else:
			var q = local_market[good_for_buy]
			Functions.buy_good_on_local_market(self, good_for_buy, q, economy_manager)
	expenses_factory_equipment = old_money - money


func buy_raw():
	var old_money = money
	var completed_plan = 0
	expenses_raw = 0
	for storage_good in raw_storage:
		var local_market      = province.player.economy_manager.local_market
		var raw_good          = storage_good.good
		var quantity          = storage_good.get_good_quantity()
		var required_quantity = storage_good.get_good_required_quantity(self)
		var quantity_for_buy  = required_quantity - quantity
		#economy_manager.demand_supply_goods[good][0] += quantity_for_buy
		
		if quantity < required_quantity:
			if local_market[raw_good] >= quantity_for_buy:
				Functions.buy_good_on_local_market(self, raw_good, quantity_for_buy, economy_manager)
				completed_plan += 1
			
			else:
				quantity_for_buy = local_market[raw_good]
				Functions.buy_good_on_local_market(self, raw_good, quantity_for_buy, economy_manager)
			
			storage_good.quantity += quantity_for_buy
			expenses_raw += quantity_for_buy * economy_manager.prices_goods[raw_good]
		
		else:
			completed_plan += 1
	
	expenses_raw = old_money - money
	if completed_plan == raw_storage.size():
		ready_to_produce = true
		return
	ready_to_produce = false


func set_based_profit():
	based_profit = economy_manager.prices_goods[good] * get_good_quantity(1)


func set_wage():
	wage = min_salary


func get_workers_quantity():
	return workers_quantity


func get_good_quantity(workers):
	var quanity = workers * get_effiency_production()
	return snapped(quanity, 0.01)


func get_effiency_production():
	var effiency = production_efficiency + good_production_efficiency + type_production_efficiency
	effiency += get_based_good_effiency_production()
	
	return effiency


func get_effiency_bonus_from_raw_in_region():
	var bonus = 0.0
	for raw in raw_storage:
		if province.goods_production_in_province.has(raw.good):
			bonus += 0.1
	return bonus
	

func get_profit():
	return income - get_expenses()


func get_expenses():
	return expenses_factory_equipment + expenses_raw + expenses_workers


func update_places_for_workers():
	if get_profit() < 0:
		if max_employed_number > 1 and subsidization == false:
			max_employed_number -= 1
	elif real_max_employed_number > max_employed_number:
		max_employed_number += 1


func check_bankrupt():
	if money < 0:
		if subsidization == true:
			var expenses = money * -1
			return expenses
		else:
			close_factory()
			return 0.0
	return 0.0


func open_factory():
	closed = false
	money = 170
	province.player.budget -= 170


func close_factory():
	closed = true
	province.get_goods_in_province()


func start_build_factory():
	var game = province.player.game
	
	while time_of_construction != time:
		await game.new_day
		time_of_construction = time_of_construction + 1
		
	province.player.list_of_factories.append(self)
	
	game.factory_manager.list_of_factories.append(self)
	
	province.get_goods_in_province()
	
	in_construction = false
	
