extends Node

const economy_reforms: Array = [
	"Налоги_на_бедных",
	"Налоги_на_богатых",
	"Пошлины",
	"Жалованье_чиновникам",
	"Снабжение_армии",
	"Образование",
]

const soc_reforms: Array = [
	"Пенсии",
	"Минимальная_зарплата",
	"Максимальный_рабочий_день",
	"Пособия_по_безработице",
	"Здравохранение",
	"Помощь_инвалидам",
]

const pol_reforms: Array = [
	"Пресса",
	"Профсоюзы",
	"Общ_собрания",
	"Право_на_обучение",
	"Политические_партии",
]


func choose_party_for_updating_popularity(player):
	var list_of_ideologies = {
		"Популисты":  0,
		"Фашисты":    check_fascists(player),
		"Коммунисты": check_communits(player),
		"Либералы":   check_liberals(player),
		"Социалисты": check_socialits(player),
	}
#	if player == Players.player:
#		breakpoint
	
	var ideology = ["Фашисты", 0]
	
	for i in list_of_ideologies:
		if list_of_ideologies[i] >= ideology[1] and i != player.ideology:
			ideology[0] = i
			ideology[1] = list_of_ideologies[i]
	return ideology[0]


func check_liberals(player):
	var cost = check_adopted_pol_reforms(player)
	return cost


func check_socialits(player):
	var cost = 0
	for i in player.list_of_soc_classes:
		if check_soc_class(i, "Рабочий"):
			cost += 0.5
	cost += check_adopted_soc_reforms(player)
	return cost
	

func check_communits(player):
	var cost = 0
	for i in player.list_of_soc_classes:
		if check_soc_class(i, "Фабричный рабочий"):
			cost += 0.5
	cost += check_adopted_soc_reforms(player)
	return cost


func check_fascists(player):
	var cost = player.policy["Реваншизм"]
	for i in player.list_of_soc_classes:
		if check_soc_class(i, "Фабричный рабочий"):
			cost += 0.1
	cost += check_adopted_soc_reforms(player)
	return cost


func check_soc_class(household, soc_class):
	if household.soc_class == soc_class:
		return true
	else:
		return false


func check_adopted_soc_reforms(player):
	var cost = 0
	for i in player.adopted_reforms:
		if soc_reforms.has(i):
			cost += 4 - player.adopted_reforms[i]
	return cost


func check_adopted_pol_reforms(player):
	var cost = 0
	for i in player.adopted_reforms:
		if pol_reforms.has(i):
			cost += 5 - player.adopted_reforms[i]
	return cost
