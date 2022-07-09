extends Node


func rng(number_1, number_2):
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(number_1,number_2)


func create_party(player, ideology, ideologies_object):
	var party = load("res://Objects/Party/Party.gd").new()
	var name_of_parties = ideologies_object.name_of_parties[ideology]
	var economy_models = ideologies_object.ideologies[ideology]["Экономическая_модель"]
	var trade_policies = ideologies_object.ideologies[ideology]["Торговая_политика"]
	
	party.name_of_party        = name_of_parties[rng(0, name_of_parties.size() - 1)]
	
	party.ideology             = ideology
	
	party.economic_model       = economy_models[rng(0, economy_models.size() - 1)]
	
	party.trade_policy         = trade_policies[rng(0, trade_policies.size() - 1)]
	
	party.cost_of_factories    = ideologies_object.economic_model[party.economic_model]["Цена_на_фабрики"]
	
	party.subsidization        = ideologies_object.economic_model[party.economic_model]["Субсидирование"]
	
	party.income_of_fabricants = ideologies_object.economic_model[party.economic_model]["Доходы_фабрикантов"]
	
	party.max_of_tarrifs       = ideologies_object.trade_policy[party.trade_policy]["Максимальные_пошлины"]
	
	party.export_of_goods      = ideologies_object.trade_policy[party.trade_policy]["Экспорт_товаров"]
	
	player.policy["Партии"].append(party)
	return party


func find_factories_with_good(good, list):
	for i in list:
		if i.good == good:
			return i
	return Label


func get_price_of_good_on_local_market(good):
	var perc = 5
	
	var price = GlobalMarket.prices_of_goods[good]
	price = price - int((float(price) / 100.0 * float(perc)) + 1)
	return price


func get_price_of_good_on_global_market(good, tariff, quanity):
	var price = GlobalMarket.prices_of_goods[good]
	return (price + (price / 100 * tariff)) * quanity


func check_good_on_global_market(good, quanity):
	var list = GlobalMarket.quanity_of_goods[good]
	for player in list:
		if list[player] >= quanity:
			return list
	
	
func buy_good_on_global_market(good, quanity, list, player):
	list[player] -= quanity
	GlobalMarket.demand[good] += quanity
	return get_price_of_good_on_global_market(good, player.economy["Пошлины"], quanity)
	

func buy_good_on_local_market(object, good, quanity, local_market, price):
	local_market[good] -= quanity
	object.money -= price * quanity


func check_good_on_local_market(good, quanity, local_market):
	return quanity <= local_market[good] 


func change_GDP(good, quanity, player): # ВВП
	player.economy["ВВП"] += GlobalMarket.prices_of_goods[good] * quanity


func set_point_of_units(point, list):
	for i in list:
		i.set_path(point)
