extends Node

var money: int = 0
var welfare:  int = 0
var player
var rent: int = 0
var income: int = 0
var quantity: int = 0

var province = null #Не удалять!

var investing: int = 0
var bonus_of_factories: float = 0.0
var moneys_for_investing: int = 200

func new_day():
	check_capitalists()
	Functions.pay_taxes(player, self, rent, "Налоги_на_богатых")


func check_capitalists():
	if player.economy["Экономическая_модель"] != "Плановая_экономика" and player.list_of_factories.size() > 0:
		quantity = 1
	else:
		quantity = 0
	#breakpoint

func invest_in_factories():
#	if money > moneys_for_investing and investing < 0.2:
#		set_bonus(1)
#		money -= moneys_for_investing
#	elif bonus_of_factories != 0.0:
#		set_bonus(-1)
	pass


func set_bonus(num):
	bonus_of_factories += 0.1 * num
	player.economy["Производительность_фабрик"] += 0.1 * num
