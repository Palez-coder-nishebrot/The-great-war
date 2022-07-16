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
	"Лекарственные_растения": "production_of_farms",
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
	"Лекарственные_растения": 0.0}

var need:                 Dictionary = {
	"Хлеб":         1,
	"Скот":         1,
	"Одежда":       1,
	"Обогреватели": 1,
}

var demand:               Dictionary = {
	"Спиртное":     1,
	"Мебель":       1,
	"Табак":        1,
	"Консервы":     1,
	"Радио":        1,
	"Чай":          1,
	"Кофе":         1,
	"Телефоны":     1,
	"Автомобили":   1,
	"Топливо":      1,
}

var needs_of_not_working_population: Array = [
	"Зерно",
	"Одежда",
	"Спиртное",
]

var demands_of_not_working_population: Array = [
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

var quanity: int = 8
var money:   int = 300

var lack = 0

var province: Object

var rent:    int = 0


func start_resourse_extraction():
	var free_pop = get_free_population()
	
	for resourse in province.resources:
		
		var quanity_of_good = (province.resources[resourse] + check_reserve(resourse)) * free_pop
		
		sale_goods(resourse, free_pop)


func bake_bread(quanity_of_good):
#	if quanity_of_good == 1:
	sale_goods("Хлеб", quanity_of_good)
		
#	else:
#		sale_goods("Хлеб", int(quanity_of_good / 2))
#		sale_goods("Зерно", int(quanity_of_good / 2))


func sale_goods(good, quanity_of_good):
	money += Functions.get_price_of_good_on_local_market(good) * quanity_of_good
	
	province.player.local_market[good] += quanity_of_good
	
	Functions.change_GDP(good, quanity_of_good, province.player)


func check_reserve(good):
	reserves_of_DP_s[good] += province.get_bonus_of_production()[tipes_of_DP[good]] + province.player.bonuses_in_production[good]
	
	if reserves_of_DP_s[good] >= 100.0:
		reserves_of_DP_s[good] = reserves_of_DP_s[good] - 100.0
		return 1
	return 0


func get_free_population():
	var free = quanity
	for i in quanity_on_factories:
		free -= quanity_on_factories[i]
	return free


func find_work():
	var free_pop = get_free_population()
	
	for i in province.list_of_buildings:
		if i.tipe == "factory" and i.closed == false and i.max_employed_number > i.employed_number and get_free_population() > 0:
			get_job(i)

func get_job(factory):
	if quanity_on_factories.has(factory):
		quanity_on_factories[factory] += 1
	else:
		quanity_on_factories[factory]  = 1
	factory.employed_number += 1
	factory.object_of_worker = self



