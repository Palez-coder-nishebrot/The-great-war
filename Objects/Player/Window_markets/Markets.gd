extends Panel

signal update(market)
signal update_info_about_output(market_)

var good: String = "Уголь"

func update_information():
	emit_signal("update", GlobalMarket.prices_of_goods)
	emit_signal("update_info_about_output", Players.player.output)#Players.player.output
	
	update_information_about_good(good)


func update_information_about_good(_good):
	good = _good
	var import_ = Players.player.import_of_goods
	var export_ = Players.player.export_of_goods
	var demand = GlobalMarket.demand
	var supply = GlobalMarket.supply
	
	$VBoxContainer2/Label.text  = ""
	$VBoxContainer2/Label2.text = ""
	
	$VBoxContainer2/Label.text = good
	if import_[good] == 0:
		$VBoxContainer2/Label2.text += "Экспорт: " + str(export_[good]) 
	else:
		$VBoxContainer2/Label2.text += "Импорт: " + str(import_[good])
	
	$VBoxContainer2/Label4.text = "Спрос:"       + str(demand[_good])
	$VBoxContainer2/Label5.text = "Предложение:" + str(supply[_good])


func _ready():
	for i in GlobalMarket.prices_of_goods:
		var button = $ScrollContainer/VBoxContainer/Button.duplicate()
		button.good = i
		button.visible = true
		button.start(self)
		
		$ScrollContainer/VBoxContainer.add_child(button)
		pass
