extends Node

var list_of_factories: Array = []

var min_salary: int = 10


func make_goods():
	for factory in list_of_factories:
		
		var good = factory.good
		var quanity = factory.list_of_workers.size() * check_bonuses_for_production(good)
		
		make_good(factory, good, factory.list_of_workers.size() * check_bonuses_for_production(good))
		
		Functions.change_GDP(good, quanity, factory.province.player)
		check_reserve(factory, factory.province, good)


func make_good(factory, good, quanity):
	factory.income = 0
	factory.province.player.local_market[good] += quanity
		
	var price = GlobalMarket.prices_of_goods[good]
	factory.money += price
	factory.income += price
		
	Functions.change_GDP(good, quanity, factory.province.player)


func check_bonuses_for_production(good):
	if GlobalMarket.bonuses_for_production_of_civilian_goods.has(good) == true:
		return GlobalMarket.bonuses_for_production_of_civilian_goods[good]
	else:
		return 1
		

func check_reserve(factory, province, good):
	if province.player.bonuses_in_production.has(good):
		factory.reserve += province.player.bonuses_in_production[good] + (
			province.get_bonus_of_production().production_of_factory + 
			get_bonuses_for_production_from_province(province, factory.purchase, good))
		
		factory.reserve -= province.player.economy["Максимальный_рабочий_день"]
		
		if factory.reserve >= 100:
			factory.reserve -= 100
			make_good(factory, good, 1)
		elif 0 > factory.reserve:
			factory.reserve = 0
		

func get_bonuses_for_production_from_province(province, purchase, good):
	var bonus = 0
	for resourse in purchase:
		if province.goods_of_factories_in_province.has(resourse):
			bonus = bonus + 15
	return bonus
	

func buy_purchase():
	for factory in list_of_factories:
		if factory.list_of_workers.size() > 0:
		
			var good = factory.good
			var purchase = factory.purchase
			var list_of_workers = factory.list_of_workers
			var province = factory.province
			var expenses = factory.money
			var local_market = factory.province.player.local_market
			
			for resourse in purchase:
				var price = GlobalMarket.prices_of_goods[resourse]
				var quanity_of_good = purchase[resourse] * list_of_workers.size()
					
				if Functions.check_good_on_local_market(resourse, quanity_of_good, local_market):
					Functions.buy_good_on_local_market(factory, resourse, quanity_of_good, local_market)
				
				elif Functions.check_good_on_global_market(resourse, quanity_of_good):
					factory.money -= Functions.buy_good_on_global_market(resourse, quanity_of_good, province.player)
				
				else:
					pass
					#print("Не хватает товаров для производства! Нужно доделать код!")
			
			pay_salary(list_of_workers, province, factory)
			expenses = expenses - factory.money
			check_bankrupt(factory, province)
			check_income(factory, expenses)
	

func check_income(factory, expenses):
	factory.income = factory.income - expenses

	
func check_bankrupt(factory, province):
	if factory.money <= 0:
		if factory.subsidization == true:
			province.player.economy["Кроны"] -= (100 - factory.money)
			factory.money = 100
		else:
			bankrupt(province, factory, factory.list_of_workers)
	
	if factory.money >= 500:
		factory.money = 500


func bankrupt(province, factory, list_of_workers):
	for i in list_of_workers:
		i.factory = null
		i.population_manager.list_of_not_working_population.append(i)
	province.get_goods_in_province()
	list_of_workers.clear()
	factory.closed = true


func start_expansion_of_factory(factory, province):
	var expansion_object = load("res://Objects/Building/Expand_factory.gd").new()
	expansion_object.building = factory
	expansion_object.game = province.player.get_parent()
	expansion_object.start_expansion_of_factory()
	
	factory.expansion = expansion_object


func pay_salary(list_of_workers, province, factory):
	var salary = (min_salary + province.player.economy["Минимальная_зарплата"])
	list_of_workers[0].population_manager.money += salary
	factory.money -= salary
