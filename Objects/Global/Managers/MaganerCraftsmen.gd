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

const hand_work = 0.15

var game: Object


func goods_production(client):
	var craftsmen = client.list_of_craftsmen.size()
	if craftsmen != 0:
		var price = GlobalMarket.prices_of_goods[good_for_production_by_craftsmen] * (craftsmen * hand_work)
		var expenses_of_craftsmen = buy_purchase(craftsmen)
		var profit = (price - expenses_of_craftsmen) / craftsmen
		
		sell_goods(client, craftsmen)
		for i in client.list_of_craftsmen:
			i.population_manager.money += profit
			i.population_manager.income += profit


func buy_purchase(craftsmen):
	var expenses = 0
	for i in purchase_of_good_for_production:
		var quantity = purchase_of_good_for_production[i] * (hand_work * craftsmen)
		GlobalMarket.demand[i] += quantity
		expenses += GlobalMarket.prices_of_goods[i] * quantity
	return expenses


func sell_goods(client, craftsmen):
	client.local_market[good_for_production_by_craftsmen] += craftsmen * hand_work
	Functions.change_GDP(good_for_production_by_craftsmen, craftsmen * hand_work, client)


func choose_good(day):
	if day == 1:
		purchase_of_good_for_production.clear()
		var good = {good = "Ткань", profit = 0}
		
		for i in list_of_goods_for_production:
			purchase_of_good_for_production.clear()
			var now_good = i
			var expenses_of_purchase = 0
			var income = GlobalMarket.prices_of_goods[i] * hand_work
			var profit = 0
			for y in GlobalMarket.goods[i]:
				var quantity = GlobalMarket.goods[i][y] * hand_work
				var price = GlobalMarket.prices_of_goods[y]
				expenses_of_purchase += price * quantity
				
			profit = income - expenses_of_purchase
			
			if profit > good.profit:
				good.good = i
				good.profit = profit
		
		good_for_production_by_craftsmen = good.good
		set_purchase(good.good)
	

func set_purchase(good):
	for y in GlobalMarket.goods[good]:
		var quantity = GlobalMarket.goods[good][y] * hand_work
		purchase_of_good_for_production[y] = quantity

