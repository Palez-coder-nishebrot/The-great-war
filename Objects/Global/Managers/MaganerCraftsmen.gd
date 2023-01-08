extends Node

var good_for_production_by_craftsmen: String     = "clothes"
var purchase_of_good_for_production:  Dictionary = {}

var list_of_goods_for_production: Array = [
	"textile",
	"lumber",
	"furniture",     
	"alcohol",
	"clothes",
	"glass",
]

const hand_work = 0.1

var game: Object


#func goods_production(client):
#	var craftsmen = client.list_of_craftsmen.size()
#	if craftsmen != 0:
#		var price = GlobalMarket.prices_of_goods[good_for_production_by_craftsmen] * (craftsmen * hand_work)
#		var expenses_of_craftsmen = buy_purchase(craftsmen, client)
#		var profit = (price - expenses_of_craftsmen) / craftsmen
#
#		sell_goods(client, craftsmen)
#		for i in client.list_of_craftsmen:
#			i.population_manager.money += profit
#			i.population_manager.income += profit
#
#
#func buy_purchase(craftsmen, client):
#	var expenses = 0
#	for i in purchase_of_good_for_production[good_for_production_by_craftsmen]:
#		var good = i.good
#		var quantity = i.quantity * hand_work * craftsmen
#
#		if client.local_market[good] < quantity:
#			GlobalMarket.demand[good] += quantity
#			expenses += GlobalMarket.prices_of_goods[good] * quantity
#		else:
#			expenses += buy_good_on_local_market(good, client.local_market, quantity)
#	return expenses
#
#
#func buy_good_on_local_market(good, local_market, quantity):
#	local_market[good] -= quantity
#	return GlobalMarket.prices_of_goods[good] * quantity
#
#
#func sell_goods(client, craftsmen):
#	client.local_market[good_for_production_by_craftsmen] += craftsmen * hand_work
#	Functions.change_GDP(good_for_production_by_craftsmen, craftsmen * hand_work, client)
#
#
#func choose_good(day):
#	if day == 1:
#		var good = {good = "Ткань", profit = 0}
#
#		for i in list_of_goods_for_production:
#			var now_good = i
#			var expenses_of_purchase = 0
#			var income = GlobalMarket.prices_of_goods[i] * hand_work
#			var profit = 0
#			for y in GlobalMarket.goods[i]:
#				var quantity = GlobalMarket.goods[i][y] * hand_work
#				var price = GlobalMarket.prices_of_goods[y]
#				expenses_of_purchase += price * quantity
#
#			profit = income - expenses_of_purchase
#
#			if profit > good.profit:
#				good.good = i
#				good.profit = profit
#
#		good_for_production_by_craftsmen = good.good
#		#set_purchase(good.good)
#

func set_purchase():
	var folder: Directory = Directory.new()
	var _err = folder.open("res://Resources/Factories/TipesOfFactories/")
	var _err_ = folder.list_dir_begin(true, true)
	
	for _i in range(17):
		var path_of_file = "res://Resources/Factories/TipesOfFactories/" + folder.get_next()
		var file = load(path_of_file)
		purchase_of_good_for_production[file.good] = file.raw
		

