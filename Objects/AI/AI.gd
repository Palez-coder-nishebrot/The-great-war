extends Node

var warhouse_of_goods: Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var local_market:      Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var export_of_goods:   Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var import_of_goods:   Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var bonuses_in_production: Dictionary = Players.bonuses_in_production.duplicate()

var economy:           Dictionary     = Players.economy.duplicate()
var policy:            Dictionary     = {
	"Правящая_партия": null,
	"Партии":          [],
	"Эмбарго":         [],
}
var buildings: Dictionary             = Players.buildings_on_start.duplicate()

var name_of_country:   String         = ""

var list_of_tiles:       Array        = []
var list_of_soc_classes: Array        = []
