extends Node2D

var warhouse_of_goods:     Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var local_market:          Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var export_of_goods:       Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var import_of_goods:       Dictionary     = GlobalMarket.prices_of_goods.duplicate()
var bonuses_in_production: Dictionary     = Players.bonuses_in_production.duplicate()

var output:                Dictionary     = Players.output.duplicate()
var economy:               Dictionary     = Players.economy.duplicate()
var policy:                Dictionary     = {
	"Правящая_партия": null,
	"Партии":          [],
	"Эмбарго":         [],
}
var buildings:         Dictionary     = Players.buildings_on_start.duplicate()

var name_of_country: String           = ""

var list_of_tiles:       Array        = []
var list_of_soc_classes: Array        = []

const speed_of_camera: int            = 50
const speed_of_zoom:   float          = 0.1
const MAX_zoom:        float          = 2.5
const MIN_zoom:        float          = 2.0

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
	
	if Input.is_action_pressed("W") and position.y >= 1300:
		position.y -= speed_of_camera

	if Input.is_action_pressed("A") and position.x >= 1500:
		position.x -= speed_of_camera
		
	if Input.is_action_pressed("S") and position.y <= 2090:
		position.y += speed_of_camera
		
	if Input.is_action_pressed("D") and position.x <= 2318:
		position.x += speed_of_camera
	

func _input(event):
	if event.is_pressed() and not event is InputEventKey:
		if event.button_index == BUTTON_WHEEL_UP:
			if $Camera2D.zoom.x >= MIN_zoom:
				$Camera2D.zoom -= Vector2(speed_of_zoom, speed_of_zoom)
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if $Camera2D.zoom.x <= MAX_zoom:
				$Camera2D.zoom += Vector2(speed_of_zoom, speed_of_zoom)
