extends Node

var need:                 Dictionary = {
	"Хлеб":         0.5,
	"Скот":         1,
	"Одежда":       1,
	"Обогреватели": 0.5,
}

var demand:               Dictionary = {
	"Спиртное":     1,
	"Мебель":       1,
	"Табак":        1,
	"Консервы":     1,
	"Радио":        1,
	"Телефоны":     1,
	"Автомобили":   1,
	"Топливо":      1,
}


var quanity: int = 8
var money:   int = 1500

var lack = 0

var province: Object

var rent:    int = 5


func build_factory(good):
	pass
	

func chose_good():
	var good = ["Сталь", -100]
	for i in GlobalMarket.goods:
		var price = check_good(i)
		if price > good[1]:
			good[0] = i
			good[1] = price
	
	if good[1] > 0:
		build_factory(good)
	
	

func check_good(good):
	var cost = 0
	
	for i in GlobalMarket.goods[good]:
		cost = cost + (GlobalMarket.prices_of_goods[good] * GlobalMarket.goods[good][i])
	
	return GlobalMarket.prices_of_goods[good] - cost
