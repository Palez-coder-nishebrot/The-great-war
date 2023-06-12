extends Node

class_name Client

signal check_available_reform(tipe_of_reform) # Сигнал вызывается!
signal research_completed # Сигнал вызывается!

const income: Array = ["tariffs", "tax_on_poor_class", "tax_on_rich_class", "Продажа_драгметаллов", "Производство"]
const factory_salary:       float = 5.0

var trade_agreements:      Dictionary     = {}
var warhouse_goods:        Dictionary     = {}
var local_market:          Dictionary     = {}
var prices_goods:          Dictionary     = {}
var export_goods:          Dictionary     = {}
var import_goods:          Dictionary     = {}
var production_goods:      Dictionary     = {}
var demand_supply_goods:   Dictionary     = {}

var accounting:            Dictionary     = {
	"Субсидии":              0,
	"Военное_производство":  0,
	"Выплаты_по_кредитам":   0,
	
	"education":             0,
	"Здравохранение":        0,
	"Пенсии":                0,
	"Пособия_по_безработице":0,
	"Снабжение_армии":       0,
	
	"tariffs": 0.0,
	"tax_on_poor_class":     0,
	"tax_on_rich_class":    0,
	"Продажа_драгметаллов": 0,
	"Производство":         0,
	"Закупка_сырья_для_ЖД": 0,
}


var population_units_list: Array = []
var regions_list:          Array = []


var tax_on_poor_class: int = 0 # Налоги на бедных
var tax_on_rich_class: int = 0 # Налоги на богатых
var tariffs:           int = 0 # Пошлины
var education:         int = 0 # Грамотность

var attracting_immigrants: int = 0 # Здравохранение
var demand_of_good:        int = 0 # Потребности населения
var population_growth:     int = 0 # Прирост населения
var pluralism_growth:      int = 0 # Прирост плюрализма

var satellite:            Object # Сателлит <Ссылка на Страну>
var ruling_party_elections: bool = false # Выборы правящей партии <Есть/Нету>
var parliamentary_elections:bool = false # Выборы в парламент <Есть/Нету>

var rich_classes_votes:     float = 0.0
var middle_classes_votes:   float = 0.0
var poor_classes_votes:     float = 0.0

var building_not_profit_factories: bool = false # Возможность строительства неприбыльных заводов
var subsidization:         bool = false # Субсидии заводов
var min_tariffs_label:     int = 0 # Минимальные пошлины (???)
var max_tariffs_label:     int = 0 # Максимальные пошлины (???)
var factory_cost:          int = 0 # Стоимость фабрик
var infrastructure_cost:   int = 0 # Строимость ЖД
var income_of_capitalists: int = 0 # Доходы Промышленникам
var max_tariffs:           int = 0 # Максимальные пошлины
var min_tariffs:           int = 0 # Минимальные пошлины

var state_bank_money:       float = 0.0 # Хранилище Гос. банка
var budget:                 int = 5000 # Бюджет
var income_in_budget:       int = 0 # Доходы в бюджет
var spending_in_budget:     int = 0 # Расходы в бюджете
var balance:                int = 0 # Дневное сальдо
var gdp:                    int = 0 # Внутренний Валовый Продукт в стране
#
#var growth_of_researching_points: int = 0 # Прирост очков исследования
#var researching_points:     int = 0 # Очки исследования
#var middle_value_education: int = 0 # Средняя грамотность
#var welfare:                int = 0 # Благосостояние
#var radio_net:              float = 0 # Покрытие страны радиосетями
#var unemployed_quantity: float = 0 # Кол-во безработных
#var stability:              float = 100 # Стабильность (Лояльность)
#
#var military_fatigue:       float = 0 # Военная усталость
#var revanchism:             int = 0 # Реваншизм
#var pluralism:              int = 0 # Плюрализм

var political_manager:          PoliticalManager       = PoliticalManager.new()
var research_manager:           ResearchManager        = ResearchManager.new()
var economy_manager:            EconomyManager         = EconomyManager.new()
var accounting_manager:         AccountingManager      = AccountingManager.new()
var trade_agreements_manager:   TradeAgreementsManager = TradeAgreementsManager.new(self)


var economic_bonuses:         EconomicBonuses        = EconomicBonuses.new()
var military_bonuses:         MilitaryBonuses        = MilitaryBonuses.new()
var technologies:             Technologies           = Technologies.new(self)
var reforms_manager:          ReformsManager         = ReformsManager.new(self)
var population_manager:       PopulationManager      = PopulationManager.new(self)

var name_of_country:         String    = ""
var path_to_file_of_country: String    = ""

var population: int = 0

var list_of_tiles:        Array        = []
var list_of_soc_classes:  Array        = []
var list_of_active_units: Array        = []
var list_of_factories:    Array        = []
var list_of_projects:     Array        = [] #ПРОЕКТЫ (НЕДОДЕЛАНО)

var national_flag:       Sprite2D 
var national_color:      Color
var researching_object:  Object
var capitalists_manager: Object = load("res://Objects/Population/Capitalists.gd").new()
var manager_of_updating_popularity_of_parties: Object = load("res://Objects/Player/ManagerOfUpdatingPopularity.gd").new()
@onready var game:       Node2D


func _init():
	set_local_market()
	var _err = research_manager.connect("research_completed", Callable(economy_manager, "set_enterprises_efficiency"))
	accounting_manager.population_units_getter = Callable(self, "get_population_units_list")
	accounting_manager.regions_list_getter = Callable(self, "get_regions_list")
	


func set_local_market():
	var path: String = "res://Resources/Good/"
	var folder = DirAccess.open(path)
	var _err_ = folder.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	var file = folder.get_next()
	
	while file != "":
		if file != "good.gd":
			var fle = load(path + file)
			local_market[fle] = 0.0
			prices_goods[fle] = float(fle.base_price)
			export_goods[fle] = 0.0
			import_goods[fle] = 0.0
			production_goods[fle] = 0.0
			warhouse_goods[fle] = 0.0
			demand_supply_goods[fle] = [0.0, 0.0]
			trade_agreements[fle]    = []
		
		file = folder.get_next()


func register_region(region):
	regions_list.append(region)
	population_units_list.append_array(region.population.population_types)


func erase_region(region):
	regions_list.erase(region)
	
	for i in region.population.population_types:
		population_units_list.erase(i)


func update_balance():
	balance = 0
	income_in_budget = 0
	spending_in_budget = 0
	for i in accounting:
		if income.has(i):
			balance += accounting[i]
			income_in_budget += accounting[i]
		else:
			balance -= accounting[i]
			spending_in_budget += accounting[i]


func get_population_units_list():
	return population_units_list


func get_regions_list():
	return regions_list


func update_values_of_population():
	pass


func get_ruling_party():
	return political_manager.ruling_party


func get_government_form():
	return political_manager.form_of_government.policy_name


func get_pension():
	return economic_bonuses.pensions


func get_factory_salary():
	return economic_bonuses.min_salary_bonus * factory_salary


func get_unemployment_benefit():
	return economic_bonuses.unemployment_benefit
