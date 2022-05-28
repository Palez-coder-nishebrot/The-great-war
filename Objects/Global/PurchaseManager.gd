extends Node


var need_of_poor_classes: Dictionary = {
	"Хлеб":         0.3,
	"Скот":         0.3,
	"Одежда":       0.5,
	"Обогреватели": 0.3,
}


func meet_the_needs(player, list_of_soc_classes):
	for soc_class in list_of_soc_classes:
		soc_class.lack = 0
		for good in need_of_poor_classes:
			
			var quanity_of_good = need_of_poor_classes[good] * soc_class.quanity
			var list = Functions.check_good_on_global_market(good, quanity_of_good)
			var price_on_local_market = Functions.get_price_of_good_on_local_market(good)
			
			pay_taxes(soc_class, player)
			
			if buy_good_from_local_market(good, quanity_of_good, player, soc_class, price_on_local_market) == false:
				if buy_good_from_global_market(list, soc_class, good, player, quanity_of_good) == false:
					soc_class.lack += 1

func buy_good_from_local_market(good, quanity_of_good, player, soc_class, price_on_local_market):
	
	if Functions.check_good_on_local_market(good, quanity_of_good, player.local_market
	) and soc_class.money >= quanity_of_good * price_on_local_market:
		Functions.buy_good_on_local_market(soc_class, good, quanity_of_good, 
		player.local_market, price_on_local_market)
		
		return true
	
	else:
		return false
	
func buy_good_from_global_market(list, soc_class, good, player, quanity_of_good):
	if list is Dictionary and soc_class.money >= Functions.get_price_of_good_on_global_market(
	good, player.economy["Пошлины"], quanity_of_good):
		soc_class.money -= Functions.buy_good_on_global_market(good, quanity_of_good, list, player)
		
		return true
	
	else:
		return false


func pay_taxes(pop, player):
	pop.money -= pop.rent #квартплата, общественный транспорт и тд
	var expences = (pop.need["Хлеб"] * pop.quanity) * GlobalMarket.prices_of_goods["Хлеб"]
	var perc = player.economy["Налоги_на_бедных"]
	var tax: int = int((float(pop.money) / 100.0 * float(perc)) * float(pop.quanity))
	
	if pop.money - tax >= expences:
		pop.money -= tax
		player.economy["Кроны"] += tax
