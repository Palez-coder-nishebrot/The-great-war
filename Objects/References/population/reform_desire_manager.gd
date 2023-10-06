extends Node


class_name ReformDesireManager


var increase_value_func:        Callable

var ide_list: Array[Ideology] = [load("res://Resources/Parties/Ideologies/Liberals.tres"), 
	load("res://Resources/Parties/Ideologies/Socialists.tres"), load("res://Resources/Parties/Ideologies/Communists.tres")]

func _init(i_func):
	increase_value_func = i_func


func update_soc_reform_desire(pop_unit: PopulationUnit, unemployment_percent):
	var value = -0.2
	var aggressiveness       = pop_unit.aggressiveness
	var pop_type             = pop_unit.population_type
	
	if unemployment_percent > 0.05:
		value += 0.1
	
	if unemployment_percent > 0.1:
		value += 0.1
	
	if unemployment_percent > 0.2:
		value += 0.1
	
	if unemployment_percent > 0.3:
		value += 0.1
	
	if unemployment_percent > 0.4:
		value += 0.1
	
	if unemployment_percent > 0.5:
		value += 0.1
	
	if unemployment_percent > 0.7:
		value += 0.1
	
	if unemployment_percent > 0.9:
		value += 0.1
	
	if pop_type == load("res://Resources/population_types/worker.tres"):
		if aggressiveness > 1.0:
			value += 0.1
		
		if aggressiveness > 3.0:
			value += 0.1
		
		if aggressiveness > 5.0:
			value += 0.1
		
		if aggressiveness > 7.0:
			value += 0.1
		
		if aggressiveness > 9.0:
			value += 0.1
	
	increase_value_func.call("soc_reform_desire", value, 10.0, 0.0)


func update_pol_reform_desire(pop_unit: PopulationUnit, unemployment_percent: float, ruling_ideology: Ideology, government_form: GovernmentForm):
	var value          = -0.2
	var pluralism      = pop_unit.pluralism
	var aggressiveness = pop_unit.aggressiveness
	
	if ruling_ideology == load("res://Resources/Parties/Ideologies/Conservators.tres"):
		value += 0.1
	
	if pop_unit.population_type == load("res://Resources/population_types/clerk.tres"):
		value += 0.1
	
	if pluralism > 0.0:
		value += 0.1
	
	if pluralism > 1.0:
		value += 0.1

	if pluralism > 2.0:
		value += 0.1
	
	if pluralism > 4.0:
		value += 0.1
	
	if pluralism > 6.0:
		value += 0.1
	
	if pluralism > 8.0:
		value += 0.1
	
	if pluralism > 9.0:
		value += 0.1
	
	if ide_list.has(ruling_ideology):
		if unemployment_percent > 0.0:
			value -= 0.1
		if unemployment_percent > 0.1:
			value -= 0.1
		if unemployment_percent > 0.2:
			value -= 0.1
		if unemployment_percent > 0.3:
			value -= 0.1
		if unemployment_percent > 0.4:
			value -= 0.1
		if unemployment_percent > 0.5:
			value -= 0.1
		if unemployment_percent > 0.6:
			value -= 0.2
		if unemployment_percent > 0.7:
			value -= 0.2
		if unemployment_percent > 0.8:
			value -= 0.2
		if unemployment_percent > 0.9:
			value -= 0.3
	
	if aggressiveness > 3.0:
		value -= 0.1
	if aggressiveness > 4.0:
		value -= 0.2
	if aggressiveness > 5.0:
		value -= 0.2
	
	increase_value_func.call("soc_reform_desire", value, 10.0, -5.0)

