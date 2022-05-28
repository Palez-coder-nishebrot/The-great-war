extends Node2D

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
var buildings:         Dictionary     = Players.buildings_on_start.duplicate()

var name_of_country: String           = ""

var list_of_tiles:       Array        = []
var list_of_soc_classes: Array        = []

const speed_of_camera: int            = 50

onready var window_province:      Panel = $CanvasLayer/Province
onready var window_markets:       Panel = $CanvasLayer/Markets
onready var window_build_factory: Panel = $CanvasLayer/Build_factory
onready var window_production:    Panel = $CanvasLayer/Production
onready var window_export_import: Panel = $CanvasLayer/Export_import
onready var window_parties:       Panel = $CanvasLayer/Parties
onready var window_taxes:         Panel = $CanvasLayer/Taxes
onready var window_reform:        Panel = $CanvasLayer/Reform
onready var information:          Panel = $CanvasLayer/Information


func _process(delta):
	if Input.is_action_pressed("W"):
		$Camera2D.position.y -= speed_of_camera

	if Input.is_action_pressed("A"):
		$Camera2D.position.x -= speed_of_camera
		
	if Input.is_action_pressed("S"):
		$Camera2D.position.y += speed_of_camera
		
	if Input.is_action_pressed("D"):
		$Camera2D.position.x += speed_of_camera
