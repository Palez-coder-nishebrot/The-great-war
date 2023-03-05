extends Node

#var economy_list: Dictionary = {
#	"Цена_на_фабрики":      "cost_of_factories",
#	"Субсидирование":       "cost_of_factories",
#	"Доходы_фабрикантов":   "cost_of_factories",
#	"Максимальные_пошлины": "cost_of_factories",
#	"Экспорт_товаров":      "cost_of_factories",
#}

func rng(number_1, number_2):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(number_1,number_2)
	

func convert_sprite_to_collision(sprite):
	var data = sprite.get_data()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(data)
	
	var polys = bitmap.opaque_to_polygons(
		Rect2(
			Vector2.ZERO,
			sprite.get_size()
		),
		5
	)
	return polys[0]
	

func pay_income_taxes(player, object, tax, income):
	var perc: float = float(tax / 100.0)
	var money: float = float(object.income) * perc
	
	object.money -= money
	player.budget += money
	
	player.accounting.tax_on_poor_class += money


func check_tariffs(price, player):
	return price * (float(player.tariffs) / 100)
	

func buy_good_on_local_market(customer, good, quanity, client):
	if good == load("res://Resources/Good/radio.tres"):
		client.radio_net += quanity
	var local_market = client.local_market
	var good_price = client.prices_goods[good]
	
	local_market[good] -= quanity
	customer.money -= good_price * quanity
	return good_price * quanity


func change_GDP(good, quanity, player): # ВВП
	player.gdp += player.prices_goods[good] * quanity
	player.production_goods[good] += quanity
