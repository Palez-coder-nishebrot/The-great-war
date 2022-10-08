extends Node

class_name Client

signal check_available_reform

var warhouse_of_goods:     Dictionary     = GlobalMarket.quanity_of_military_goods.duplicate()
var local_market:          Dictionary     = Players.output.duplicate()
var export_of_goods:       Dictionary     = Players.output.duplicate()
var import_of_goods:       Dictionary     = Players.output.duplicate()
var accounting:            Dictionary     = Players.accounting.duplicate()

#var production:            Dictionary     = GlobalMarket.production.duplicate()
var output:                Dictionary     = Players.output.duplicate()
var economy:               Dictionary     = {
	"Экономическая_модель": "Свободная_экономика",
	"Торговая_политика":    "Меркантилизм",
	
	"Цена_на_фабрики":      0,
	"Субсидирование":       false,
	"Доходы_фабрикантов":   80,
	
	"Пошлины":              0,
	"Максимальные_пошлины": 15,
	
	"Налоги_на_бедных":     0,
	"Налоги_на_богатых":    0,
	
	"Жалованье_чиновникам": 0,
	"Снабжение_армии":      10,
	"Минимальная_зарплата": 0,
	"Пенсии":               0,
	"Максимальный_рабочий_день": 0,
	"Пособия_по_безработице":    0,
	"Здравохранение":            0,
	"Образование":               0,
	"Помощь_инвалидам":          0,
}
var policy:                Dictionary     = {
	"Стабильность":    100,
	"Агрессивность":   0,
	"Военная_усталость": 0,
	"Реваншизм":         0,
	"Правящая_партия": null,
	"Партии":          [],
	"Эмбарго":         [],
	"Поддержка_партий":{
		"Популисты": 70, #73
		"Фашисты":   5, #2
		"Коммунисты":5,
		"Либералы":  10,
		"Социалисты":10,
	},
	"Реформы": {
		"Очки_соц_реформ": 0,
		"Очки_пол_реформ": 0,
		
		"Откат_соц_реформ":    false,
		"Откат_пол_реформ":    false,
		"Принятие_соц_реформ": false,
		"Принятие_пол_реформ": false,
	},
	"Режим":            "",
	"Внешняя_политика": "",
	"Сателлит":                 null,
	"Экономическая_интеграция": null,
}

var adopted_reforms: Dictionary = {
	"Налоги_на_бедных":  2,
	"Налоги_на_богатых": 2,
	"Пошлины":           2,
	"Снабжение_армии":      1,
	"Образование":          1,
	
	"Политические_партии":  1,
	"Право_на_обучение":    1,
	"Общ_собрания":         1,
	"Профсоюзы":            1,
	"Пресса":               1,
	
	"Пенсии":               1,
	"Минимальная_зарплата": 1,
	"Максимальный_рабочий_день": 1,
	"Пособия_по_безработице":    1,
	"Здравохранение":            1,
	"Помощь инвалидам":          1,
}

var ideology:           String = ""
var form_of_government: String = ""
var economic_policy:    String = ""
var trade_policy:       String = ""
var foreign_policy:     String = ""

var satellite:            Object
var elections:            bool = false
var subsidization:        bool = false
var income_of_capitalists: int = 0
var max_of_tarrifs:       int = 0
var min_of_tarrifs:       int = 0

var revanchism:             int = 0
var pluralism:              int = 0
var budget:                 int = 0
var gdp:                    int = 0
var researching_points:     int = 0
var welfare:                int = 0
var radio_net:              float = 0
var quantity_of_unemployed: float = 0
var military_fatigue:       float = 0

var economic_bonuses: EconomicBonuses = EconomicBonuses.new()
var military_bonuses: MilitaryBonuses = MilitaryBonuses.new()
var technologies:     Technologies    = Technologies.new()
var parties_manager:  PartiesManager  = PartiesManager.new()

var name_of_country:        String     = ""

var units_for_training:   Array        = Players.units_for_training
var list_of_tiles:        Array        = []
var list_of_soc_classes:  Array        = []
var list_of_craftsmen:    Array        = []
var list_of_active_units: Array        = []
var list_of_factories:    Array        = []

var national_flag:      Sprite 
var national_color:     Color
var researching_object: Object
var capitalists_manager:    Object = load("res://Objects/Population/Capitalists.gd").new()
var manager_of_updating_popularity_of_parties: Object = load("res://Objects/Player/ManagerOfUpdatingPopularity.gd").new()
onready var game:       Node2D


func update_expenses_on_railways():
	var quantity_on_steel = 0.0
	var quantity_on_lumber = 0.0
	for tile in list_of_tiles:
		var railways = tile.railways
		var quantity = railways.level * railways.quantity
		quantity_on_steel  += quantity
		quantity_on_lumber += quantity
	buy_goods_for_railways(quantity_on_steel, "steel")
	buy_goods_for_railways(quantity_on_lumber, "lumber")
	

func buy_goods_for_railways(quantity, good):
	var old_budget = budget
	if quantity > local_market[good]:
		var r = quantity - local_market[good]
		GlobalMarket.demand[good] += r
		
		budget -= r * GlobalMarket.prices_of_goods_from_other_countries[good]
		budget -= local_market[good] * GlobalMarket.prices_of_goods[good]
		
		local_market[good] = 0
	
	else:
		local_market[good] -= quantity
		budget -= quantity * GlobalMarket.prices_of_goods[good]
	
	accounting["Закупка_сырья_для_ЖД"] += old_budget - budget


func update_stability():
#	var factors_of_change = (policy["Реваншизм"] + policy["Военная_усталость"] + (-welfare)) * 0.1
#
#	policy["Стабильность"] -= factors_of_change
#
#	if policy["Стабильность"] > 100:
#		policy["Стабильность"] = 100
#	elif policy["Стабильность"] < 0:
#		policy["Стабильность"] = 0
#
#	update_popularity_of_parties()
	pass

func update_popularity_of_parties():
	pass
#	var ideology = manager_of_updating_popularity_of_parties.choose_party_for_updating_popularity(self)
#
#	var pop_with_new_ideology = 100 - policy["Стабильность"]
#	pop_with_new_ideology = pop_with_new_ideology * 0.01
#	policy["Поддержка_партий"][ideology] += pop_with_new_ideology
#	policy["Поддержка_партий"][policy["Правящая_партия"].ideology] -= pop_with_new_ideology


func update_welfare_of_population():
	welfare = capitalists_manager.welfare * capitalists_manager.quantity
	for i in list_of_tiles:
		welfare += i.population_manager.welfare
		
	welfare = welfare / list_of_tiles.size()


func update_population_growth():
	for i in list_of_tiles:
		var growth_of_new_generation = i.population_manager.welfare + economic_bonuses.population_growth
		i.population_manager.new_generation += growth_of_new_generation
		i.population_manager.growth_of_new_generation = growth_of_new_generation
		
		if i.population_manager.new_generation > 200:
			game.spawn_household(i)
		elif i.population_manager.new_generation < 0:
			i.population_manager.new_generation = 0
			i.population_manager.growth_of_new_generation = 0


func update_point_of_reforms():
	pass
#	var points_of_soc_reform = 0
#	var points_of_pol_reform = 0
#	var points_of_cancel_pol_reforms = 0
#	var points_of_cancel_soc_reforms = 0
#
#	for i in policy["Партии"]:
#		var popularity = policy["Поддержка_партий"][i.ideology]
#
#		if i.supporting_soc_reforms == 0:
#			points_of_cancel_soc_reforms += popularity
#		else:
#			points_of_soc_reform += i.supporting_soc_reforms * popularity
#
#		if i.supporting_pol_reforms == 0:
#			points_of_cancel_pol_reforms += popularity
#		else:
#			points_of_pol_reform += i.supporting_pol_reforms * popularity
#
#	policy["Реформы"]["Очки_соц_реформ"] += check_reforms(points_of_soc_reform, points_of_cancel_soc_reforms)
#	policy["Реформы"]["Очки_пол_реформ"] += check_reforms(points_of_pol_reform, points_of_cancel_pol_reforms)
#
#	#print(policy["Реформы"])
#
#	update_supporting_reforms("Очки_соц_реформ", points_of_soc_reform)
#	update_supporting_reforms("Очки_пол_реформ", points_of_pol_reform)
#
#	update_available_reform("Очки_пол_реформ", "Принятие_пол_реформ", "Откат_пол_реформ")
#	update_available_reform("Очки_соц_реформ", "Принятие_соц_реформ", "Откат_соц_реформ")
	
	

func check_reforms(points_of_reform, points_of_cancel_reforms):
#	if points_of_cancel_reforms > points_of_reform:
#		return 0
#	else:
#		return points_of_reform - points_of_cancel_reforms
	pass


func update_supporting_reforms(reform, points_of_reform):
#	if points_of_reform > 0:
#		policy["Реформы"][reform] += 1
#	elif points_of_reform < 0:
#		policy["Реформы"][reform] -= 1
	pass


func update_available_reform(reform, reform_adoption, reform_rollback):
	pass
#	if policy["Реформы"][reform] >= 10:
#		policy["Реформы"][reform_adoption] = true
#		policy["Реформы"][reform_rollback] = false
#		emit_signal("check_available_reform")
#
#	elif policy["Реформы"][reform] <= -10:
#		policy["Реформы"][reform_adoption] = false
#		policy["Реформы"][reform_rollback] = true
#		emit_signal("check_available_reform")
#	else:
#		policy["Реформы"][reform_adoption] = false
#		policy["Реформы"][reform_rollback] = false

