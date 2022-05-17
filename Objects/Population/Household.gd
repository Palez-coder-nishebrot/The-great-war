extends Node


var quanity_on_factories: Dictionary = {}

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
}

var reserves_of_DP_s: Dictionary = {
	"Уголь":     0.0,
	"Железо":    0.0,
	"Нефть":     0.0,
	"Резина":    0.0,
	"Хлопок":    0.0,
	"Зерно":     0.0,
	"Скот":      0.0,
	"Селитра":   0.0,
	"Древесина": 0.0,
	"Табак":     0.0,
}

var need:                 Dictionary = {
	"Хлеб":         0.3,
	"Скот":         0.5,
	"Одежда":       0.5,
	"Обогреватели": 0.3,
}

var demand:               Dictionary = {
	"Спиртное":     1,
	"Мебель":       0.5,
	"Табак":        0.5,
	"Консервы":     0.3,
	"Тракторы":     0.5,
	"Радио":        0.5,
	"Телефоны":     0.5,
	"Автомобили":   0.5,
	"Топливо":      0.3,
}

var quanity: int = 8
var money:   int = 300

var lack = 0

var province: Object

var rent:    int = 0


func start_resourse_extraction():
	for i in get_free_population():
		for resourse in province.resources:
			
			var quanity_of_good = province.resources[resourse] + check_reserve(resourse)
			
			if resourse == "Зерно":
				bake_bread(quanity_of_good)
			
			else:
				sale_goods(resourse, quanity_of_good)
	
	pay_taxes()


func bake_bread(quanity_of_good):
	if quanity_of_good == 1:
		sale_goods("Хлеб", quanity_of_good)
		
	else:
		sale_goods("Хлеб", quanity_of_good / 2)
		sale_goods("Зерно", quanity_of_good / 2)


func sale_goods(good, quanity_of_good):
	money += Functions.get_price_of_good_on_local_market(good) * quanity_of_good
	
	province.player.local_market[good] += quanity_of_good
	
	Functions.change_GDP(good, quanity_of_good, province.player)


func check_reserve(good):
	reserves_of_DP_s[good] += province.get_bonus_of_production()[tipes_of_DP[good]]
	
	if reserves_of_DP_s[good] >= 100.0:
		reserves_of_DP_s[good] = 0.0
		return 1
	return 0


func pay_taxes():
	money -= rent #квартплата, общественный транспорт и тд
	var expences = (need["Хлеб"] * quanity) * GlobalMarket.prices_of_goods["Хлеб"]
	var perc = province.player.economy["Налоги_на_бедных"]
	var tax: int = int((float(money) / 100.0 * float(perc)) * float(quanity))
	
	if money - tax >= expences:
		money -= tax
		province.player.economy["Кроны"] += tax


func get_free_population():
	var free = quanity
	for i in quanity_on_factories:
		free -= quanity_on_factories[i]
	return free


func find_work():
	var free_pop = get_free_population()
	
	for i in province.list_of_buildings:
		if i.tipe == "factory" and i.closed == false and i.max_employed_number > i.employed_number:
			get_job(i)

func get_job(factory):
	if quanity_on_factories.has(factory):
		quanity_on_factories[factory] += 1
	else:
		quanity_on_factories[factory]  = 1
	factory.employed_number += 1
	factory.object_of_worker = self


#func meet_the_needs():
#	for i in need:
#		if buy_goods(i, need[i] * quanity) == false:
#			return
#
#
#func buy_goods(good, quanity_of_good):
#
#	var list = Functions.check_good_on_global_market(good, quanity_of_good)
#
#	if Functions.check_good_on_local_market(good, quanity_of_good, 
#	province.player.local_market) and money >= Functions.get_price_of_good_on_local_market(good):
#		var price_on_local_market = Functions.get_price_of_good_on_local_market(good)
#		Functions.buy_good_on_local_market(self, good, quanity, province.player.local_market, price_on_local_market)
#
#	elif list is Dictionary and money >= Functions.get_price_of_good_on_global_market(
#		good, province.player.economy["Пошлины"], quanity):
#		money -= Functions.buy_good_on_global_market(good, quanity_of_good, list, province.player)
#
#	else:
#		return false

