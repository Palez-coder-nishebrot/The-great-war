extends Node

var warhouse_of_goods:     Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var local_market:          Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var export_of_goods:       Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var import_of_goods:       Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var bonuses_in_production: Dictionary     = Players.bonuses_in_production.duplicate()

var output:                Dictionary     = Players.output.duplicate()
var speed_production:      Dictionary     = Players.output.duplicate()
var economy:               Dictionary     = Players.economy.duplicate()
var policy:                Dictionary     = {
	"Правящая_партия": null,
	"Партии":          [],
	"Эмбарго":         [],
}

var bonuses_of_units: Dictionary = {
	"Атака":      Players.list_of_units,
	"Оборона":    Players.list_of_units,
	"Дисциплина": Players.list_of_units,
	"Разведка":   Players.list_of_units,
	"Скорость":   Players.list_of_units,
	"ПВО":        Players.list_of_units,
	"Потребление_припасов": Players.list_of_units,
	"Потребление_снарядов": 1,
	"Снабжение":            1,
}

var levels_of_technologies: Dictionary = Players.levels_of_technologies

var buildings: Dictionary             = Players.buildings_on_start.duplicate()

var name_of_country:   String         = ""

var units_for_training:  Array        = Players.units_for_training
var list_of_tiles:       Array        = []
var list_of_soc_classes: Array        = []

var national_flag:      Sprite 
var national_color:     Color
var researching_object: Object
var capitalists:        Object = (load("res://Objects/Population/Capitalists.gd").new()).start()
