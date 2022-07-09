extends Node2D

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

var buildings:         Dictionary     = Players.buildings_on_start.duplicate()

var name_of_country: String           = ""

var units_for_training:   Array        = Players.units_for_training
var list_of_tiles:        Array        = []
var list_of_soc_classes:  Array        = []
var list_of_active_units: Array        = []

const speed_of_camera: int            = 50
const speed_of_zoom:   float          = 0.1
const MAX_zoom:        float          = 2.5
const MIN_zoom:        float          = 1.0

var national_flag:      Sprite 
var national_color:     Color
var researching_object: Object
var capitalists:        Object = (load("res://Objects/Population/Capitalists.gd").new()).start()

onready var window_province:      Panel = $CanvasLayer/Province
onready var window_markets:       Panel = $CanvasLayer/Markets
onready var window_build_factory: Panel = $CanvasLayer/Build_factory
onready var window_production:    Panel = $CanvasLayer/Production
onready var window_export_import: Panel = $CanvasLayer/Export_import
onready var window_parties:       Panel = $CanvasLayer/Parties
onready var window_taxes:         Panel = $CanvasLayer/Taxes
onready var window_reform:        Panel = $CanvasLayer/Reform
onready var window_population:    Panel = $CanvasLayer/Population
onready var window_research:      Panel = $CanvasLayer/Research
onready var window_research_end:  Panel = $CanvasLayer/Research_end
onready var information:          Panel = $CanvasLayer/Information
onready var window_train_army:    Panel = $CanvasLayer/Train_army
onready var window_list_of_units: ScrollContainer = $CanvasLayer/List_of_units
onready var game:                 Node2D          = get_parent()


func _process(delta):
	
	if Input.is_action_pressed("W") and position.y >= 1200:
		position.y -= speed_of_camera

	if Input.is_action_pressed("A") and position.x >= 1600:
		position.x -= speed_of_camera
		
	if Input.is_action_pressed("S") and position.y <= 2100:
		position.y += speed_of_camera
		
	if Input.is_action_pressed("D") and position.x <= 2400:
		position.x += speed_of_camera
	

func _input(event):
	if event.is_pressed() and not event is InputEventKey:
		if event.button_index == BUTTON_WHEEL_UP:
			if $Camera2D.zoom.x >= MIN_zoom:
				$Camera2D.zoom -= Vector2(speed_of_zoom, speed_of_zoom)
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if $Camera2D.zoom.x <= MAX_zoom:
				$Camera2D.zoom += Vector2(speed_of_zoom, speed_of_zoom)
