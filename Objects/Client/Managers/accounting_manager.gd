extends RefCounted

class_name AccountingManager

var income:        float
var expenses:      float
var daily_balance: float
var gdp:           float

var poor_class_taxes:   float = 0.0
var middle_class_taxes: float = 0.0
var rich_class_taxes:   float = 0.0
var tariffs:            float = 0.0

var contributions:                 float = 0.0
var factories_subsidies_expenses:  float = 0.0

var education_expenses:            float = 0.0
var healthcare_expenses:           float = 0.0
var unemployment_benefit_expenses: float = 0.0
var pensions_expenses:             float = 0.0
var subsidies_expenses:            float = 0.0
var debts_expenses:                float = 0.0
var army_expenses:                 float = 0.0

var unemployed_quantity:       int   = 0
var population_literacy:       float = 0.0
var population_quantity:       int   = 0
var population_welfare:        float = 0.0
var population_aggressiveness: float = 0.0
var population_pluralism:      float = 0.0

var produced_goods: Dictionary = {}
var projects_list:  Array      = []

var production_points:  float = 0.0

var population_units_getter:     Callable
var regions_list_getter:         Callable
var contributions_getter:        Callable
var healthcare_getter:           Callable
var unemployment_benefit_getter: Callable
var pensions_getter:             Callable
var army_getter:                 Callable


func get_accounting_value(variable: String):
	return get(variable)


func set_accounting_values(variable: String, value: float):
	set(variable, value)


func _init(client):
	set_dict()
	var _err = ManagerDay.connect("set_accounting", Callable(self, "set_info"))
	_err     = ManagerDay.connect("clear_accounting", Callable(self, "clear_accounting"))
	client.research_manager.accounting_value_getter = get_accounting_value
	
	population_units_getter = Callable(client, "get_population_units_list")
	regions_list_getter     = Callable(client, "get_regions_list")


func set_dict():
	var path: String = "res://Resources/Good/"
	var folder: DirAccess = DirAccess.open(path)
	var _err_ = folder.list_dir_begin()
	var file = folder.get_next()
	
	while file != "":
		if file != "good.gd":
			var fle = load(path + file)
			produced_goods[fle] = 0.0
		
		file = folder.get_next()


func clear_accounting():
	poor_class_taxes   = 0.0
	middle_class_taxes = 0.0
	rich_class_taxes   = 0.0
	tariffs            = 0.0
	factories_subsidies_expenses = 0.0


func set_info():
	get_population_statistics()
	get_balance()


func get_population_statistics():
	clear_dict(produced_goods)
	
	var plu        = 0.0
	var agr        = 0.0
	var unemployed = 0
	var literacy = 0.0
	var pop_quantity = 0
	var welfare = 0.0
	var gdp_ = 0.0
	
	var list = regions_list_getter.call()
	var pop_classes_q = 0.0
	
	if list.size() == 0:
		return
	
	for region in list:
		for pop_unit in region.population.population_types:
			unemployed   += pop_unit.unemployed_quantity
			pop_quantity += pop_unit.quantity
			
			if pop_unit.quantity != 0:
				pop_classes_q += 1
				literacy      += pop_unit.literacy
				welfare       += pop_unit.welfare
				agr           += pop_unit.aggressiveness
				plu           += pop_unit.pluralism
				
		
		for enterprise in region.DP_list + region.get_factories_list():
			gdp_ += enterprise.income
			produced_goods[enterprise.good] += enterprise.selling_goods_quantity
	
	population_aggressiveness = snappedf(agr / pop_classes_q, 0.1)
	population_pluralism      = snappedf(plu / pop_classes_q, 0.1)
	population_literacy       = snappedf(literacy / pop_classes_q, 0.1)
	population_welfare        = snappedf(welfare / pop_classes_q, 0.1) 
	
	unemployed_quantity = unemployed
	population_quantity = pop_quantity
	gdp                 = gdp_
	

func get_balance():
	income = poor_class_taxes + middle_class_taxes + rich_class_taxes + tariffs
	expenses = education_expenses + army_expenses + debts_expenses + healthcare_expenses + pensions_expenses + subsidies_expenses + unemployment_benefit_expenses
	daily_balance = income - expenses


func pay_tariffs(money):
	tariffs += money


func pay_subsidies(money):
	factories_subsidies_expenses += money


func clear_dict(dict):
	for i in dict:
		dict[i] = 0
