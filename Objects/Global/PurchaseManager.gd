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
			
			if Functions.check_good_on_local_market(good, quanity_of_good, player.local_market
			) and soc_class.money >= quanity_of_good * price_on_local_market:
				
				Functions.buy_good_on_local_market(soc_class, good, quanity_of_good, 
				player.local_market, price_on_local_market)
					
			elif list is Dictionary and soc_class.money >= Functions.get_price_of_good_on_global_market(
			good, player.economy["Пошлины"], quanity_of_good):
				soc_class.money -= Functions.buy_good_on_global_market(good, quanity_of_good, list, player)
			
			else: 
				soc_class.lack += 1


