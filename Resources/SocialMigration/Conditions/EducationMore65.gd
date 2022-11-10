extends Resource


func check(pop_manager): #Проверяем среднее значение Обрзованности!
	if pop_manager.province.player.middle_value_education > 65:
		return 1
	else:
		return 0
