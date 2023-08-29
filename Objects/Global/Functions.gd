extends Node


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


func get_tariff(good, quanity, economy_manager: EconomyManager):
	var price = economy_manager.prices_goods[good]
	var tariff = economy_manager.tariffs
	
	if tariff > 0:
		tariff += economy_manager.tariffs_efficiency
	return (price * quanity) * tariff


func get_good_price(price, imp_quantity, quantity, tariffs, tariffs_efficiency):
	
	var price_from_loc  = quantity * price
	var price_from_glob = (imp_quantity * price) + ((imp_quantity * price) * tariffs)
	
	return price_from_loc + price_from_glob


func pay_tariffs(money, economy_manager):
	economy_manager.pay_tariffs(money)


func check_goods_quantity(local_market, good, quantity):
	if local_market[good] > quantity or is_equal_approx(local_market[good], quantity):
		return true
	return false


func buy_good_on_local_market(customer, good, quanity, economy_manager: EconomyManager, imp_quantity = 0.0):
	var local_market = economy_manager.local_market
	var goods_price  = economy_manager.prices_goods[good] * quanity
	
	var money_tariff = get_tariff(good, imp_quantity, economy_manager)
	
	var total_price = money_tariff + goods_price
	
	pay_tariffs(money_tariff, economy_manager)
	
	local_market[good] -= quanity
	customer.money -= total_price
	
	if total_price < 0:
		breakpoint
	return total_price


func create_details_panel(parent):
	var panel = load("res://Objects/Player/details_panel/details_panel.tscn").instantiate()
	Players.get_player().canvas_layer.add_child(panel)
	panel.connect_parent(parent)
	return panel
