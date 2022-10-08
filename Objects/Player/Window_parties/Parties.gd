extends Panel

onready var player = get_parent().get_parent()

var list_of_answers: Dictionary = {true: "Да", false: "Нет"}

func update():
	var policy = player.policy
	for i in policy["Партии"]:
		var panel = load("res://Objects/Player/Window_parties/Party.tscn").instance()
		panel.party = i
		panel.update()
		$ScrollContainer/VBoxContainer.add_child(panel)
	#$ScrollContainer/VBoxContainer.add_child(load("res://Objects/Player/Window_parties/Party.tscn").instance())


func update_information():
	for i in $ScrollContainer/VBoxContainer.get_children():
		i.update()
	update_information_of_country()
	

func update_information_of_country():
	pass
#	get_status_of_country(policy) 
#	$CharsOfCountry/VBoxContainer/FormOfGovernment.text = "Режим: " + policy["Режим"]
#	$CharsOfCountry/VBoxContainer/RulingParty.text = "Правящая партия: " + policy["Правящая_партия"].name_of_party
#	$CharsOfCountry/VBoxContainer/ForeignPolicy.text = "Внешняя политика: " + policy["Внешняя_политика"]
#	$CharsOfCountry/VBoxContainer/Aggressiveness.text = "Агрессивность: " +  str(policy["Агрессивность"])
#
#	$CharsOfCountry/VBoxContainer/ModelOfEconomy.text = "Модель экономики:" + economy["Экономическая_модель"]
#	$CharsOfCountry/VBoxContainer/TradePolicy.text = "Торговая политика:" + economy["Торговая_политика"]
#	$CharsOfCountry/VBoxContainer/Subsidization.text = "Субсидии: " + list_of_answers[economy["Субсидирование"]]
#	$CharsOfCountry/VBoxContainer/CostOfFactories.text = "Цена Фабрик: +" + str(economy["Цена_на_фабрики"]) + "%"
#	$CharsOfCountry/VBoxContainer/IncomeOfCapitalists.text = "Доходы Фабрикантов: " + str(economy["Доходы_фабрикантов"]) + "%"
#	$CharsOfCountry/VBoxContainer/MaxTariffs.text = "Максимальные пошлины: " + str(economy["Максимальные_пошлины"]) + "%"


func get_status_of_country(policy):
	$CharsOfCountry/VBoxContainer/StatusPolicy.text = "Независимая страна"
	$CharsOfCountry/VBoxContainer/StatusEconomy.text = "Нет экономической интеграции"
	
	if policy["Сателлит"] != null:
		$CharsOfCountry/VBoxContainer/StatusPolicy.text = "Сателлит:" + policy["Сателлит"].name_of_country
	
	if policy["Экономическая_интеграция"] != null:
		$CharsOfCountry/VBoxContainer/StatusEconomy.text = "Экономическая интеграция:" + policy["Экономическая_интеграция"].name_of_country
		
