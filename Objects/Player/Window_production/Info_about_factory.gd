extends Panel

var factory


func update_information():
	if factory != null:
		if factory.province.player != Players.player:
			factory = null
			return
		else:
			$VBoxContainer/Label.text = Players.goods_to_factory[factory.good]
			$VBoxContainer/Label2.text = "Бюджет: " + str(factory.money)
			$VBoxContainer/Label3.text = "Доходы: " + str(factory.income)
			show_resourses()
			$VBoxContainer/Label5.text = "Рабочие: " + str(factory.employed_number) + "/" + str(factory.max_employed_number)
			show_bonuses_for_production()
	
func show_resourses():
	$VBoxContainer/Label4.text = ""
	var token = 1
	for i in factory.purchase:
		if token == factory.purchase.size():
			$VBoxContainer/Label4.text += i + ": " + str(factory.purchase[i])
		else:
			$VBoxContainer/Label4.text += i + ": " + str(factory.purchase[i]) + "\n"
			token = token + 1


func show_bonuses_for_production():
	$VBoxContainer/Label6.text = "Бонус к выпуску продукции от: \n"
	$VBoxContainer/Label6.text += "*Сырье, производимое в провинции: +" + str(factory.get_bonuses_for_production_from_province()) + "% \n"
	$VBoxContainer/Label6.text += "*Базовый бонус: x" + str(factory.check_bonuses_for_production()) + "\n"
	$VBoxContainer/Label6.text += "*Бонус от технологий: +" + str(factory.province.player.bonuses_in_production[factory.good]) + "%"


func get_base_bonus():
	pass


func exit():
	visible = false
	pass
