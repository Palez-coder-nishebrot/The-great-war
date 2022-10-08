extends Node

var economy_list: Dictionary = {
	"Цена_на_фабрики":      "cost_of_factories",
	"Субсидирование":       "cost_of_factories",
	"Доходы_фабрикантов":   "cost_of_factories",
	"Максимальные_пошлины": "cost_of_factories",
	"Экспорт_товаров":      "cost_of_factories",
}

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


func create_party(player, ideology, ideologies_object):
	var party = load("res://Objects/Party/Party.gd").new()
	var name_of_parties = ideologies_object.name_of_parties[ideology]
	var economy_models = ideologies_object.ideologies[ideology]["Экономическая_модель"]
	var trade_policies = ideologies_object.ideologies[ideology]["Торговая_политика"]
	var foreign_policy = ideologies_object.ideologies[ideology]["Внешняя_политика"]
	
	party.player = player
	
	party.name_of_party        = name_of_parties[rng(0, name_of_parties.size() - 1)]
	
	party.ideology             = ideology
	
	party.economic_model       = economy_models[rng(0, economy_models.size() - 1)]
	
	party.trade_policy         = trade_policies[rng(0, trade_policies.size() - 1)]
	
	party.foreign_policy       = foreign_policy[rng(0, foreign_policy.size() - 1)]
	party.aggressiveness       = ideologies_object.foreign_policy[party.foreign_policy]["Агрессивность"]
	
	party.cost_of_factories    = ideologies_object.economic_model[party.economic_model]["Цена_на_фабрики"]
	
	party.subsidization        = ideologies_object.economic_model[party.economic_model]["Субсидирование"]
	
	party.income_of_fabricants = ideologies_object.economic_model[party.economic_model]["Доходы_фабрикантов"]
	
	party.max_of_tarrifs       = ideologies_object.trade_policy[party.trade_policy]["Максимальные_пошлины"]
	
	party.supporting_soc_reforms = ideologies_object.ideologies[ideology]["Поддержка_соц_реформ"]
	party.supporting_pol_reforms = ideologies_object.ideologies[ideology]["Поддержка_пол_реформ"]
	
	player.policy["Партии"].append(party)
	return party


#func set_economy(player, party):
#
#	pass
	

func pay_taxes(player, object, rent, tipe_of_tax):
	var perc: float = float(player.economy[tipe_of_tax]) / 100.0
	var tax: float = float(object.income) * perc
	#print(tax)
	
	object.money -= rent #квартплата, общественный транспорт и тд
	object.money -= tax
	player.budget += tax
	
	if tipe_of_tax == "Налоги_на_богатых":
		pass
	player.accounting[tipe_of_tax] += tax


func check_good_on_global_market(good, quanity, player):
	var price = GlobalMarket.prices_of_goods_from_other_countries[good] * quanity
	var tariffs = check_tariffs(price, player)
	return price + tariffs


func buy_good_on_global_market(good, quanity, player):
	if good == "radio":
		player.radio_net += quanity
	
	var price = GlobalMarket.prices_of_goods_from_other_countries[good] * quanity
	var tariffs = check_tariffs(price, player)
	
	GlobalMarket.demand[good] += quanity
	player.import_of_goods[good] += quanity
	
	player.budget += tariffs
	player.accounting["Пошлины"] += tariffs
	return price + tariffs


func check_tariffs(price, player):
	return float(price) / 100.0 * player.economy["Пошлины"]


func check_good_on_local_market(good, quanity, local_market):
	return quanity <= local_market[good] 
	

func buy_good_on_local_market(object, good, quanity, local_market):
	if good == "radio":
		object.province.player.radio_net += 1
	
	local_market[good] = local_market[good] - quanity
	object.money -= GlobalMarket.prices_of_goods[good] * quanity
	return GlobalMarket.prices_of_goods[good] * quanity


func change_GDP(good, quanity, player): # ВВП
	player.gdp += GlobalMarket.prices_of_goods[good] * quanity
	player.output[good] += quanity


func set_point_of_units(point, list):
	for i in list:
		i.set_path(point)
