extends Node

#var economy_list: Dictionary = {
#	"Цена_на_фабрики":      "cost_of_factories",
#	"Субсидирование":       "cost_of_factories",
#	"Доходы_фабрикантов":   "cost_of_factories",
#	"Максимальные_пошлины": "cost_of_factories",
#	"Экспорт_товаров":      "cost_of_factories",
#}

func rng(number_1, number_2):
	var RNG = RandomNumberGenerator.new()
	RNG.randomize()
	return RNG.randi_range(number_1,number_2)
	

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


func swap(first_index, second_index, array):
	var t = array[first_index]
	array[first_index] = array[second_index]
	array[second_index] = t


func pay_income_taxes(player, object, tax, income):
	var perc: float = float(tax / 100.0)
	var money: float = float(object.income) * perc
	
	object.money -= money
	player.budget += money
	
	player.accounting.tax_on_poor_class += money


func check_tariffs(price, player):
	return price * (float(player.tariffs) / 100)
	

func buy_good_on_local_market(customer, good, quanity, economy_manager):
	var local_market = economy_manager.local_market
	var good_price = economy_manager.prices_goods[good]
	
	economy_manager.demand_supply_goods[good][0] += quanity
	local_market[good] -= quanity
	customer.money -= good_price * quanity
	return good_price * quanity


func create_details_panel(parent):
	var panel = load("res://Objects/Player/details_panel/details_panel.tscn").instantiate()
	Players.player.canvas_layer.add_child(panel)
	panel.connect_parent(parent)
	return panel
