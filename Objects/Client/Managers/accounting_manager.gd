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

var contributions:      float = 0.0

var education_expenses:            float = 0.0
var healthcare_expenses:           float = 0.0
var unemployment_benefit_expenses: float = 0.0
var pensions_expenses:             float = 0.0
var subsidies_expenses:            float = 0.0
var debts_expenses:                float = 0.0
var army_expenses:                 float = 0.0

var unemployed_quantity: int   = 0
var population_literacy: float = 0.0
var population_quantity: int   = 0
var population_welfare:  float = 0

var population_units_getter:     Callable
var regions_list_getter:         Callable
var contributions_getter:        Callable
var healthcare_getter:           Callable
var unemployment_benefit_getter: Callable
var pensions_getter:             Callable
var army_getter:                 Callable


func set_accounting_values(variable: String, value: float):
	set(variable, value)


func _init():
	ManagerDay.connect("set_accounting", Callable(self, "set_info"))


func set_info():
	get_population_statistics()
	get_balance()


func get_population_statistics():
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
			literacy     += pop_unit.literacy
			pop_quantity += pop_unit.quantity
			welfare      += pop_unit.welfare
			if pop_unit.quantity != 0:
				pop_classes_q += 1
		
		for enterprise in region.DP_list + region.get_factories_list():
			gdp_ += enterprise.income
	
#	var pop_classes_q = list.size() * list[0].population.population_types.size()
	population_literacy = literacy / pop_classes_q
	population_welfare  = snappedf(welfare / pop_classes_q, 0.1)
	
	unemployed_quantity = unemployed
	population_quantity = pop_quantity
	gdp                 = gdp_
	

func get_balance():
	income = poor_class_taxes + middle_class_taxes + rich_class_taxes + tariffs
	expenses = education_expenses + army_expenses + debts_expenses + healthcare_expenses + pensions_expenses + subsidies_expenses + unemployment_benefit_expenses
	daily_balance = income - expenses
