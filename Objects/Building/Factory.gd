extends Node

const tipe = "factory"

const min_salary:        int          = 10
const time:              int          = 3
var money:               int          = 500#100
var income:              int          = 0
var max_employed_number: int          = 1
var employed_number:     int          = 0
var reserve:             int          = 0
var subsidization:       bool         = false
var closed:              bool         = false
var reserve_used:        bool         = false
var good:            String           = ""
var name_of_factory: String           = ""
var purchase:    Dictionary           = {}

var province:         Object
var object_of_worker: Object
var expansion:        Object


func make_goods():
	var quanity = employed_number * check_bonuses_for_production()
	
	income = 0
	province.player.local_market[good] += quanity
	province.player.output[good] += quanity
	
	var price = Functions.get_price_of_good_on_local_market(good) * quanity
	money += price
	income += price
	
	Functions.change_GDP(good, quanity, province.player)
	
	if reserve_used == false:
		check_reserve()
	else:
		reserve_used = true
		

func check_bonuses_for_production():
	if GlobalMarket.bonuses_for_production_of_civilian_goods.has(good) == true:
		return GlobalMarket.bonuses_for_production_of_civilian_goods[good]
	else:
		return 1


func check_reserve():
	if province.player.bonuses_in_production.has(good):
		reserve += province.player.bonuses_in_production[good] + (
			province.get_bonus_of_production().production_of_factory + get_bonuses_for_production_from_province())
		
		if reserve >= 100:
			reserve -= 100
			reserve_used = true
			make_goods()


func get_bonuses_for_production_from_province():
	var bonus = 0
	var list_of_goods_of_factories_in_province = province.get_goods_of_factories_in_province(good)
	for resourse in purchase:
		if list_of_goods_of_factories_in_province.has(resourse):
			bonus = bonus + 15
	return bonus


func buy_purchase():
	var expenses = money
	var local_market = province.player.local_market
	var list_of_goods_of_factories_in_province = province.get_goods_of_factories_in_province(good)
	
	for resourse in purchase:
		var list = Functions.check_good_on_global_market(resourse, purchase[resourse])
		
		if Functions.check_good_on_local_market(resourse, purchase[resourse], local_market):
			Functions.buy_good_on_local_market(self, resourse, purchase[resourse], local_market, Functions.get_price_of_good_on_local_market(resourse))
		
		elif list is Dictionary:
			money -= Functions.buy_good_on_global_market(resourse, 
			purchase[resourse], list, province.player)
		
		else:
			print("Не хватает товаров для производства! Нужно доделать код!")
	
	pay_salary()
	expenses = expenses - money
	check_bankrupt()
	check_income(expenses)


func check_income(expenses):
	income = income - expenses

	
func check_bankrupt():
	if money <= 0:
		if subsidization == true:
			province.player.economy["Кроны"] -= (100 - money)
			money = 100
		else:
			bankrupt()
	if money >= 500:
		money = 500


func bankrupt():
	object_of_worker.quanity_on_factories.erase(self)
	employed_number = 0
	closed = true


func start_expansion_of_factory():
	expansion = load("res://Objects/Building/Expand_factory.gd").new()
	expansion.building = self
	expansion.game = province.player.get_parent()
	expansion.start_expansion_of_factory()


func pay_salary():
	var salary = (min_salary + province.player.economy["Минимальная_зарплата"]) * employed_number
	object_of_worker.money += salary
	money -= salary


func open_factory():
	closed = false
	province.player.economy["Кроны"] -= 150
	money = 150
