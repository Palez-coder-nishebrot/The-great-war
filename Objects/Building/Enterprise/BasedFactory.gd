extends Enterprise


class_name Factory

const expanding_cost:    float        = 200
const min_clerks_salary: float        = 5 * PopulationWorldManager.POP_COEF
const min_salary:        float        = 2 * PopulationWorldManager.POP_COEF
const time:              int          = 10
var time_of_construction:int          = 0

var basic_profit:        float        = 0.0 # Прибыль, когда на заводе работает 100 рабочих
var expenses_raw:        int          = 0
var expenses_factory_equipment: int   = 0
var real_max_employed_number:   int   = 13000
var max_employed_number: int          = 13000

var workers_quantity:      float        = 0.0
var clerks_quantity:       float        = 0.0

var clerks_wage: float = 0.0

var bonus_from_produced_goods: float  = 0.0

var ready_to_produce:    bool         = true
var subsidization:       bool         = false
var in_construction:     bool         = false
var type_factory:      Resource
var name_of_factory:   String
#var raw:               Array
var raw_storage:       Array

var province:          Object
var expansion_project: ExpansionProject

var workers_unit:      Object
var clerks_unit:       Object


func _init(region = null):
	var _err = ManagerDay.connect("produce_goods",            produce_goods)
	_err = ManagerDay.connect("set_based_profit",             set_based_profit)
	_err = ManagerDay.connect("add_salary_supplement",        add_salary_supplement)
	_err = ManagerDay.connect("set_factories_subsidies",      set_factories_subsidies)
	_err = connect("update_employed_places",                  set_places_for_workers)
	wage = 2
	
	if region != null:
		_err = connect("update_produced_goods", Callable(region, "get_produced_goods"))


func produce_goods():
	if ready_to_produce == false or workers_quantity == 0 or closed:
		selling_goods_quantity = 0
		income = 0
		return
	var q = get_good_quantity(workers_quantity, clerks_quantity)
	var p = economy_manager.prices_goods[good]
	
	selling_goods_quantity = q
	economy_manager.demand_supply_goods[good][1] = economy_manager.demand_supply_goods[good][1] + q
	economy_manager.local_market[good]           = economy_manager.local_market[good] + q
	income = q * p
	money += income
	set_empty_raw_storage()


func set_empty_raw_storage():
	for i in raw_storage:
		i.quantity = 0


func buy_raw():
	expenses_raw = 0.0
	
	if closed:
		return
	
	var old_money = money
	var completed_plan = 0
	for storage_good in raw_storage:
		var local_market      = province.client_owner.economy_manager.local_market
		var raw_good          = storage_good.good
		var quantity          = storage_good.get_good_quantity()
		var required_quantity = storage_good.get_good_required_quantity(self)
		var quantity_for_buy  = required_quantity - quantity
		
		var market_good_quantity = local_market[raw_good]
		var purchase_price = 0
		#economy_manager.demand_supply_goods[good][0] += quantity_for_buy
		
		if not is_zero_approx(quantity_for_buy) and quantity_for_buy > 0.0:
			if market_good_quantity > quantity_for_buy or is_equal_approx(market_good_quantity, quantity_for_buy):
				purchase_price = Functions.buy_good_on_local_market(self, raw_good, quantity_for_buy, economy_manager)
				completed_plan += 1
			
			else:
				var importing_goods_q = GlobalMarket.fill_lack(economy_manager, raw_good, quantity_for_buy - market_good_quantity)
				market_good_quantity = local_market[raw_good]
				if market_good_quantity > quantity_for_buy or is_equal_approx(quantity_for_buy, market_good_quantity):
					completed_plan += 1
			
				quantity_for_buy = market_good_quantity
				purchase_price = Functions.buy_good_on_local_market(self, raw_good, quantity_for_buy, economy_manager, importing_goods_q)
			
			economy_manager.demand_supply_goods[raw_good][0] += required_quantity
			storage_good.quantity += quantity_for_buy
			storage_good.purchase_price = purchase_price
		
		else:
			completed_plan += 1
	
	expenses_raw = old_money - money
	if completed_plan == raw_storage.size():
		ready_to_produce = true
		return
	ready_to_produce = false


func set_based_profit():
	basic_profit = economy_manager.prices_goods[good] * get_good_quantity(100, 0)


func set_wage():
	var supplement = 0.0
	
	if get_workers_quantity() != 0:
		supplement = salary_supplement / get_workers_quantity()
	
	wage        = min_salary        + supplement
	clerks_wage = min_clerks_salary + supplement


func set_profit():
	profit = income - get_expenses()


func get_workers_quantity():
	return workers_quantity + clerks_quantity


func get_good_quantity(workers_q, clerks_q):
	var workers_productivity = (workers_q * craftsmen_labour_productivity) + (clerks_q * clerks_labour_productivity)
	var quantity              = workers_productivity * get_factory_production_efficiency()
	
	if quantity < 0:
		breakpoint
	return quantity


func get_factory_production_efficiency():
	var effiency = production_efficiency + bonus_from_produced_goods
	
	return effiency


func set_region_raw_bonus():
	bonus_from_produced_goods = 0.0
	for raw in raw_storage:
		if province.produced_goods.has(raw.good):
			bonus_from_produced_goods += 0.1


func get_expenses():
	return expenses_factory_equipment + expenses_raw + expenses_workers


func update_places_for_workers():
	if closed:
		return
	
#	if profit < 0:
#		if max_employed_number > 10:
#			if workers_quantity < max_employed_number:
#				max_employed_number = workers_quantity
#
#			max_employed_number -= 10
#			workers_unit.fire_workers_from_factory(self, "workers_quantity", 10)
#
#	else:
#		max_employed_number = real_max_employed_number


func set_places_for_workers():
	if closed:
		max_employed_number = 0
		workers_unit.fire_workers_from_factory(self, "workers_quantity", workers_quantity)
		clerks_unit.fire_workers_from_factory(self, "clerks_quantity", clerks_quantity)


func set_factories_subsidies():
	update_places_for_workers()
	if profit < 0:
		if subsidization == true and money < 0:
			var client    = province.client_owner
			var sub_money = get_expenses()
			client.economy_manager.budget -= sub_money
			money                         += sub_money
		
		if money < 0:
			close_enterprise()
		
	

func expand_factory(client):
	if client.economy_manager.budget > expanding_cost and expansion_project == null:
		expansion_project = ExpansionProject.new(self, province.client_owner.game)
		expansion_project.start_factory_expansion()
