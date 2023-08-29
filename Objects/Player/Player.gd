extends Node2D

#class_name Player

const speed_of_camera: float            = 0.25

const ACTIVE_LEFT_BORDER:  bool = false
const ACTIVE_RIGHT_BORDER: bool = false
const ACTIVE_UP_BORDER:    bool = false
const ACTIVE_DOWN_BORDER:  bool = false

@onready var canvas_layer:         CanvasLayer = $CanvasLayer
@onready var camera:               Camera2D = $Camera2D
@onready var buttons:              Panel = $CanvasLayer/buttons_panel
@onready var window_province:      Panel = $CanvasLayer/province_window
@onready var window_markets:       Panel = $CanvasLayer/markets_window
@onready var window_build_factory: Control = $CanvasLayer/building_factory_window
@onready var window_production:    Panel = $CanvasLayer/production_window
@onready var window_parties:       Panel = $CanvasLayer/parliament_window
@onready var window_taxes:         Panel = $CanvasLayer/accounting_window
@onready var window_reform:        Panel = $CanvasLayer/reforms_window
@onready var window_population:    Panel = $CanvasLayer/population_window
@onready var window_research:      Panel = $CanvasLayer/research_window
@onready var information:          Panel = $CanvasLayer/information_panel
@onready var window_diplomacy:     Panel = $CanvasLayer/diplomacy_window
@onready var menu_panel:           Panel = $CanvasLayer/menu_panel

var client


func _ready():
	var _err = client.connect("check_available_reform", Callable(window_reform, "check_available_reform"))
	var _err_ = client.connect("research_completed", Callable(self, "report_research_completed"))
	

func report_research_completed(technology):
	var message = load("res://Objects/Player/Message/Message/Message.tscn").instantiate()
	message.set_title("research_completed", technology)
	$CanvasLayer.add_child(message)


func _process(_delta):
	if Input.is_action_pressed("W"):# and position.y >= 1200:
		camera.position.y -= speed_of_camera

	if Input.is_action_pressed("A"):# and position.x >= 1600:
		camera.position.x -= speed_of_camera
		
	if Input.is_action_pressed("S"):# and position.y <= 2100:
		camera.position.y += speed_of_camera
		
	if Input.is_action_pressed("D"):# and position.x <= 2400:
		camera.position.x += speed_of_camera
	

func _input(_event):
	if Input.is_action_just_pressed("ui_esc"):
		menu_panel.visible = not menu_panel.visible
#	if event.is_pressed() and not event is InputEventKey:
#		if event.button_index == BUTTON_WHEEL_UP:
#			if $Camera2D.zoom.x >= MIN_zoom:
#				$Camera2D.zoom -= Vector2(speed_of_zoom, speed_of_zoom)
#		elif event.button_index == BUTTON_WHEEL_DOWN:
#			if $Camera2D.zoom.x <= MAX_zoom:
#				$Camera2D.zoom += Vector2(speed_of_zoom, speed_of_zoom)


