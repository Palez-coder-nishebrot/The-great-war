extends Node

class_name Client

signal check_available_reform(tipe_of_reform) # Сигнал вызывается!
signal research_completed # Сигнал вызывается!

const income: Array = ["tariffs", "tax_on_poor_class", "tax_on_rich_class", "Продажа_драгметаллов", "Производство"]

var trade_agreements:      Array          = []
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

var tax_on_poor_class: int = 0 # Налоги на бедных
var tax_on_rich_class: int = 0 # Налоги на богатых
var tariffs:           int = 0 # Пошлины
var education:         int = 0 # Грамотность
var pensions:          int = 0 # Пенсии
var min_salary:        int = 0 # Мин. ЗП
var healthcare:        int = 0 # Здравохранение
var unemployment_benefit: int = 0 # Пособия по безработице

var attracting_immigrants: int = 0 # Здравохранение
var demand_of_good:        int = 0 # Потребности населения
var population_growth:     int = 0 # Прирост населения
var pluralism_growth:      int = 0 # Прирост плюрализма

var ideology:           String = "" # Правящая деология
var form_of_goverment:  String = "" # Форма правления
var economic_policy:    String = "" # Эк. политика
var trade_policy:       String = "" # Торговая политика
var foreign_policy:     String = "" # Внешняя политика
var satellite:            Object # Сателлит <Ссылка на Страну>
var elections:            bool = false # Выборы <Есть/Нету>

var building_not_profit_factories: bool = false # Возможность строительства неприбыльных заводов
var subsidization:         bool = false # Субсидии заводов
var min_tariffs_label:     int = 0 # Минимальные пошлины (???)
var max_tariffs_label:     int = 0 # Максимальные пошлины (???)
var cost_of_factories:     int = 0 # Стоимость фабрик
var cost_of_infrastructure:int= 0 # Строимость ЖД
var income_of_capitalists: int = 0 # Доходы Промышленникам
var max_tariffs:           int = 0 # Максимальные пошлины
var min_tariffs:           int = 0 # Минимальные пошлины

var money_of_state_bank:    float = 0.0 # Хранилище Гос. банка
var budget:                 int = 5000 # Бюджет
var income_in_budget:       int = 0 # Доходы в бюджет
var spending_in_budget:     int = 0 # Расходы в бюджете
var balance:                int = 0 # Дневное сальдо
var gdp:                    int = 0 # Внутренний Валовый Продукт в стране

var growth_of_researching_points: int = 0 # Прирост очков исследования
var researching_points:     int = 0 # Очки исследования
var middle_value_education: int = 0 # Средняя грамотность
var welfare:                int = 0 # Благосостояние
var radio_net:              float = 0 # Покрытие страны радиосетями
var quantity_of_unemployed: float = 0 # Кол-во безработных
var stability:              float = 100 # Стабильность (Лояльность)

var military_fatigue:       float = 0 # Военная усталость
var revanchism:             int = 0 # Реваншизм
var pluralism:              int = 0 # Плюрализм

var economic_bonuses:         EconomicBonuses        = EconomicBonuses.new()
var military_bonuses:         MilitaryBonuses        = MilitaryBonuses.new()
var technologies:             Technologies           = Technologies.new(self)
var parties_manager:          PartiesManager
var reforms_manager:          ReformsManager         = ReformsManager.new(self)
var population_manager:       PopulationManager      = PopulationManager.new(self)
var trade_agreements_manager: TradeAgreementsManager = TradeAgreementsManager.new()

var name_of_country:         String    = ""
var path_to_file_of_country: String    = ""

var population: int = 0

var list_of_tiles:        Array        = []
var list_of_soc_classes:  Array        = []
var list_of_active_units: Array        = []
var list_of_factories:    Array        = []
var list_of_projects:     Array        = [] #ПРОЕКТЫ (НЕДОДЕЛАНО)

var national_flag:       Sprite 
var national_color:      Color
var researching_object:  Object
var capitalists_manager: Object = load("res://Objects/Population/Capitalists.gd").new()
var manager_of_updating_popularity_of_parties: Object = load("res://Objects/Player/ManagerOfUpdatingPopularity.gd").new()
onready var game:       Node2D


func _init():
	set_local_market()


func set_local_market():
	var folder: Directory = Directory.new()
	var path: String = "res://Resources/Good/"
	var _err = folder.open(path)
	var _err_ = folder.list_dir_begin(true, true)
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
		
		file = folder.get_next()


func update_supporting_party_by_client(party):
	parties_manager.supporting_party_by_client = party


func update_expenses_on_railways():
	var quantity_on_steel  = 0.0
	var quantity_on_lumber = 0.0
	var quantity_on_gas    = 0.0
	var quantity_on_el_parts = 0.0
	for tile in list_of_tiles:
		var railways = tile.railways
		var quantity = railways.level * railways.quantity
		quantity_on_steel  += quantity + 0.01
		quantity_on_lumber += quantity
		quantity_on_el_parts += quantity - 0.01
		quantity_on_gas    += railways.level * 0.01
	buy_goods_for_railways(quantity_on_steel, "steel")
	buy_goods_for_railways(quantity_on_lumber, "lumber")
	buy_goods_for_railways(quantity_on_gas,    "gas")
	buy_goods_for_railways(quantity_on_el_parts, "el_parts")


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


func update_values_of_population():
	welfare = 0
	middle_value_education = 0
	var population_quantity: int = 0
	for tile in list_of_tiles:
		for population_unit in tile.population.population_types:
			population_quantity += population_unit.quantity
			welfare += population_unit.welfare
			middle_value_education += population_unit.literacy * population_unit.quantity
	
	welfare = int(float(welfare) / list_of_tiles.size())
	middle_value_education = int(float(middle_value_education) / float(population_quantity))
