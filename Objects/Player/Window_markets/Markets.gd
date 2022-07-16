extends Panel

signal update(market)

var good: String = "Уголь"

func update_information():
	emit_signal("update", GlobalMarket.prices_of_goods)
	
	update_information_about_good(good)



func update_information_about_good(_good):
	good = _good
	var import_ = Players.player.import_of_goods
	var export_ = Players.player.export_of_goods
	
	$VBoxContainer2/Label.text  = ""
	$VBoxContainer2/Label2.text = ""
	
	$VBoxContainer2/Label.text = good
	if import_[good] == 0:
		$VBoxContainer2/Label2.text += "Экспорт: " + str(export_[good]) 
	else:
		$VBoxContainer2/Label2.text += "Импорт: " + str(import_[good])
