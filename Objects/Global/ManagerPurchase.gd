extends Node

var tipes_of_DP: Dictionary = {
	"Уголь":     "production_of_mines",
	"Железо":    "production_of_mines",
	"Нефть":     "production_of_mines",
	"Резина":    "production_of_farms",
	"Хлопок":    "production_of_farms",
	"Зерно":     "production_of_farms",
	"Скот":      "production_of_farms",
	"Селитра":   "production_of_mines",
	"Древесина": "production_of_farms",
	"Табак":     "production_of_farms",
	"Хлеб":      "production_of_farms",
	"Лекарственные_растения": "production_of_farms",
}

const needs_of_working_city_population: Array = [
	"Хлеб",
	"Скот",
	"Одежда",
	"Обогреватели",
]

const needs_of_working_village_population: Array = [
	"Одежда",
]

const needs_of_not_working_population: Array = [
	"Зерно",
	"Одежда",
	"Спиртное",
]

const tipes_of_population: Dictionary = {
	"Деревенский_житель": "needs_of_working_village_population",
	"Городской_житель":   "needs_of_working_city_population",
}

const demands_of_not_working_population: Array = [
	"Мебель",
	"Спиртное",
	"Хлеб",
	"Консервы",
	"Топливо",
	"Табак",
	"Лекарства",
	"Чай",
	"Кофе",
]

const rent: int = 0
var list_of_population_managers: Array = []

func meet_the_needs():
	for population_manager in list_of_population_managers:
		population_manager.lack = 0
		var player = population_manager.player
		
		for good in get(tipes_of_population[population_manager.tipe]):
			if population_manager.money > GlobalMarket.prices_of_goods[good]:
				var quanity_of_pop = population_manager.list_of_soc_classes.size()
				var quanity_of_good = quanity_of_pop
				var price_of_good = GlobalMarket.prices_of_goods[good]
				var local_market = player.local_market

				pay_taxes(population_manager, player)
				
				if quanity_of_good <= local_market[good]:
					Functions.buy_good_on_local_market(population_manager, good, quanity_of_good, local_market)
		
				elif quanity_of_good <= GlobalMarket.quanity_of_goods[good]:
					population_manager.money -= Functions.buy_good_on_global_market(good, quanity_of_good, player)
				
				else:
					pass
					#print("Не хватает товаров для потребления! Нужно доделать код!")
			else:
				population_manager.lack = 12
				break


func pay_taxes(pop, player):
	
	if pop.money >= rent:
		pop.money -= rent #квартплата, общественный транспорт и тд
		var expences = GlobalMarket.prices_of_goods["Хлеб"]
		var perc = player.economy["Налоги_на_бедных"]
		var tax: int = int(float(pop.money) / 100.0 * float(perc))
		
		if pop.money - tax >= expences:
			pop.money -= tax
			player.economy["Кроны"] += tax


func resourse_extraction(game):
	for population_manager in list_of_population_managers:
		var size = population_manager.list_of_not_working_population.size()
		if size > 0:
			for good in population_manager.province.resources.keys():
				
				population_manager.player.local_market[good] += size
				Functions.change_GDP(good, size, population_manager.player)
				population_manager.money += GlobalMarket.prices_of_goods[good] * size
			
			find_work(population_manager.list_of_not_working_population, population_manager.province)
	

func check_province(soc_class, province):
	if province.get_groups().has("Village"):
		soc_class.tipe = "Деревенский_житель"
	else:
		soc_class.tipe = "Городской_житель"
		

func find_work(list_of_not_working_population, province):
	var soc_class = list_of_not_working_population[0]
	
	if not province.get_groups().has("Village"):
		for factory in province.list_of_buildings:
			if factory.tipe == "factory" and factory.closed == false and factory.max_employed_number > factory.list_of_workers.size():
				get_job(factory, soc_class, list_of_not_working_population)
				return


func get_job(factory_, soc_class, list_of_not_working_population):
	list_of_not_working_population.erase(soc_class)
	soc_class.factory = factory_
	factory_.list_of_workers.append(soc_class)
