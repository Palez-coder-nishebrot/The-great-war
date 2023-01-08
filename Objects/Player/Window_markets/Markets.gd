extends Panel

signal update(market)
#signal update_info_about_output(market_)
#signal update_info_about_warhouse(warhouse)

var good: String = "coal"

func update_information():
	emit_signal("update")
	#emit_signal("update_info_about_output", Players.player.output)
	#emit_signal("update_info_about_warhouse", Players.player.warhouse_of_goods)
	
	update_information_about_good(good)


func update_information_about_good(_good):
	good = _good
	var import_ = Players.player.import_of_goods
	var export_ = Players.player.export_of_goods
	var demand = GlobalMarket.demand
	var supply = GlobalMarket.supply
	var price = GlobalMarket.prices_of_goods_from_other_countries
#	var warhouse_of_goods = Players.player.warhouse_of_goods
	
	$VBoxContainer2/Label.text  = ""
	$VBoxContainer2/Label2.text = ""
	
	$VBoxContainer2/Label.text = good
	if import_[good] == 0:
		$VBoxContainer2/Label2.text += "Экспорт: " + str(export_[good]) 
	else:
		$VBoxContainer2/Label2.text += "Импорт: " + str(import_[good])
	
	$VBoxContainer2/Label4.text = "Спрос:"       + str(demand[good])
	$VBoxContainer2/Label5.text = "Предложение:" + str(supply[good])
	
	if price.has(good):
		$VBoxContainer2/Label6.text = "Цена на глобальном рынке:" + str(price[good])
	else:
		$VBoxContainer2/Label6.text = ""


#func _ready():
#	spawn_buttons(GlobalMarket.prices_of_goods, $ScrollContainer/VBoxContainer)
#	spawn_buttons(Players.player.warhouse_of_goods, $ScrollContainer2/VBoxContainer)


func spawn_buttons(market, container):
	for i in market:
		var button = container.get_node("Button").duplicate()
		button.good = i
		button.visible = true
		button.start(self)
		
		container.add_child(button)
