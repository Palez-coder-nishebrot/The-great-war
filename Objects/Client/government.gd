extends Node


class_name Government


const RECHARGING_DAYS_AFTER_REFORMING: int = 5


var gui_name: String = "parliament"


var soc_refoms_avaliable:      bool = false
var pol_refoms_avaliable:      bool = false

var back_soc_refoms_avaliable: bool = false
var back_pol_refoms_avaliable: bool = false

var days_before_opportunity_reform: int = 2


var parties_seats: Dictionary = {
	load("res://Resources/Parties/Ideologies/Communists.tres"):    100.0,
	load("res://Resources/Parties/Ideologies/Conservators.tres"):  0.0,
	load("res://Resources/Parties/Ideologies/Fascists.tres"):      0.0,
	load("res://Resources/Parties/Ideologies/Liberals.tres"):      0.0,
	load("res://Resources/Parties/Ideologies/Libertarians.tres"):  0.0,
	load("res://Resources/Parties/Ideologies/Socialists.tres"):    0.0,
}


func _init():
	SceneStorage.game.connect("new_day", new_day)


func update_recharging_days():
	days_before_opportunity_reform = RECHARGING_DAYS_AFTER_REFORMING
	disable_reform_opportunity()


func opportunity_reform_avaliable():
	if days_before_opportunity_reform > 0:
		return false
	return true
	

func new_day():
	if days_before_opportunity_reform != 0:
		days_before_opportunity_reform -= 1
		
		if opportunity_reform_avaliable():
			start_avoting()
	else:
		start_avoting()


func start_avoting():
	disable_reform_opportunity()
	
	var ref_soc = 0
	var ref_pol = 0
	
	var rol_soc = 0
	var rol_pol = 0
	
	for i in parties_seats:
		var quantity = parties_seats[i]
		
		ref_soc += i.supporting_soc_reforms * parties_seats[i]
		ref_pol += i.supporting_pol_reforms * parties_seats[i]
		
		rol_soc += i.rollback_soc_reforms * parties_seats[i]
		rol_pol += i.rollback_pol_reforms * parties_seats[i]
	
	if ref_soc > 50:
		soc_refoms_avaliable = true
	
	if ref_pol > 50:
		pol_refoms_avaliable = true
	
	if rol_soc > 50:
		back_soc_refoms_avaliable = true
	
	if rol_pol > 50:
		back_pol_refoms_avaliable = true


func disable_reform_opportunity():
	soc_refoms_avaliable      = false
	pol_refoms_avaliable      = false
	
	back_soc_refoms_avaliable = false
	back_pol_refoms_avaliable = false
