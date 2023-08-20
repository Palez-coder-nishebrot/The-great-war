extends Node


class_name ReformDesireManager


var add_soc_reform_desire_func: Callable
var add_pol_reform_desire_func: Callable


func _init(s_func, p_func):
	add_soc_reform_desire_func = s_func
	add_pol_reform_desire_func = p_func


func update_soc_reform_desire(unemployment_percent: float, pluralism: float, literacy: float, welfare: int, pop_type: Resource):
	var growth = -0.1
	growth += school_system(pluralism, literacy)
	growth += social_payments(unemployment_percent, welfare)
	
	if pop_type != load("res://Resources/population_types/worker.tres"):
		growth += social_payments(unemployment_percent, welfare)
	
	add_soc_reform_desire_func.call(growth)


func school_system(pluralism: float, literacy: float):
	var value = 0.0
	
	if 1.0 > pluralism and pluralism > 0.0:
		value += 0.0
	elif 4.0 > pluralism and pluralism > 1.0 and literacy < 30:
		value += 0.1
	elif 6.0 > pluralism and pluralism > 4.0 and literacy < 50:
		value += 0.2
	elif 8.0 > pluralism and pluralism > 6.0 and literacy < 70:
		value += 0.3
	elif  10.1 > pluralism and pluralism > 8.0 and literacy < 80:# 8-10
		value += 0.4
	return value


func social_payments(unemployment_percent: float, welfare: int):
	var value = 0.0
	if 0.2 > unemployment_percent and unemployment_percent > 0.0:
		value += 0.0
	elif 0.5 > unemployment_percent and unemployment_percent > 0.2 and welfare < 3:
		value += 0.05
	elif 1.0 > unemployment_percent and unemployment_percent > 0.5:
		value += 0.1
	elif unemployment_percent == 1.0:
		value += 0.11
	return value
	

func working_conditions(pluralism: float, welfare: int):
	var value = 0.0
	
	if 1.0 > pluralism and pluralism > 0.0:
		value += 0.0
	elif 6.0 > pluralism and pluralism > 1.0 and welfare < 3:
		value += 0.1
	elif  10.0 > pluralism and pluralism > 6.0 and welfare < 4:
		value += 0.2
	return value


func update_pol_reform_desire():
	pass
