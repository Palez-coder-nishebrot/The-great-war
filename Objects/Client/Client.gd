extends Node

class_name Client

signal check_available_reform(tipe_of_reform)
signal research_completed

const income: Array = ["tariffs", "tax_on_poor_class", "tax_on_rich_class", "Продажа_драгметаллов", "Производство"]

var warhouse_of_goods:     Dictionary     = GlobalMarket.quanity_of_military_goods.duplicate()
var local_market:          Dictionary     = Players.output.duplicate()
var export_of_goods:       Dictionary     = Players.output.duplicate()
var import_of_goods:       Dictionary     = Players.output.duplicate()
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

var output:                Dictionary     = Players.output.duplicate()

var tax_on_poor_class: int = 0
var tax_on_rich_class: int = 0
var tariffs:           int = 0
var education:         int = 0
var pensions:          int = 0
var min_salary:        int = 0
var healthcare:        int = 0
var unemployment_benefit: int = 0

var attracting_immigrants: int = 0
var demand_of_good:        int = 0
var population_growth:     int = 0
var pluralism_growth:      int = 0

var ideology:           String = ""
var form_of_goverment:  String = ""
var economic_policy:    String = ""
var trade_policy:       String = ""
var foreign_policy:     String = ""
var satellite:            Object
var elections:            bool = false

var building_not_profit_factories: bool = false
var subsidization:         bool = false
var min_tariffs_label:     int = 0
var max_tariffs_label:     int = 0
var cost_of_factories:     int = 0
var cost_of_infrastructure:int= 0
var income_of_capitalists: int = 0
var max_tariffs:           int = 0
var min_tariffs:           int = 0

var money_of_state_bank:    int = 0
var budget:                 int = 5000
var income_in_budget:       int = 0
var spending_in_budget:     int = 0
var balance:                int = 0
var gdp:                    int = 0

var growth_of_researching_points: int = 0
var researching_points:     int = 0
var middle_value_education: int = 0
var welfare:                int = 0
var radio_net:              float = 0
var quantity_of_unemployed: float = 0
var stability:              float = 100

var military_fatigue:       float = 0
var revanchism:             int = 0
var pluralism:              int = 0

var economic_bonuses:   EconomicBonuses = EconomicBonuses.new()
var military_bonuses:   MilitaryBonuses = MilitaryBonuses.new()
var technologies:       Technologies    = Technologies.new(self)
var parties_manager:    PartiesManager  #= PartiesManager.new(self)
var reforms_manager:    ReformsManager  = ReformsManager.new(self)
var population_manager: PopulationManager = PopulationManager.new(self)


var name_of_country:         String    = ""
var path_to_file_of_country: String    = ""

var population: int = 0

var units_for_training:   Array        = Players.units_for_training
var list_of_tiles:        Array        = []
var list_of_soc_classes:  Array        = []
var list_of_craftsmen:    Array        = []
var list_of_active_units: Array        = []
var list_of_factories:    Array        = []
var list_of_projects:     Array        = []

var national_flag:       Sprite 
var national_color:      Color
var researching_object:  Object
var capitalists_manager: Object = load("res://Objects/Population/Capitalists.gd").new()
var manager_of_updating_popularity_of_parties: Object = load("res://Objects/Player/ManagerOfUpdatingPopularity.gd").new()
onready var game:       Node2D


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
	for i in list_of_tiles:
		welfare += i.population_manager.welfare
		middle_value_education += i.population_manager.education
	
	welfare = welfare / list_of_tiles.size()
	middle_value_education = middle_value_education / list_of_tiles.size()


#func update_population_growth():
#	for i in list_of_tiles:
#		var growth_of_new_generation = i.population_manager.welfare + economic_bonuses.population_growth
#		i.population_manager.new_generation += growth_of_new_generation
#		i.population_manager.growth_of_new_generation = growth_of_new_generation
#
#		if i.population_manager.new_generation > 100:
#			i.population_manager.quantity_of_workers += 1
#			var proc = (1 / i.population_manager.education) * 100
#			i.population_manager.education -= ((i.population_manager.education / 100) * proc) + 1
#			i.population_manager.set_needs(i.population_manager)
#		elif i.population_manager.new_generation < 0:
#			i.population_manager.new_generation = 0
#			i.population_manager.growth_of_new_generation = 0
