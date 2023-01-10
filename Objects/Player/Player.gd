extends Client

const speed_of_camera: int            = 50
const speed_of_zoom:   float          = 0.1
const MAX_zoom:        float          = 2.5
const MIN_zoom:        float          = 1.0

const ACTIVE_LEFT_BORDER:  bool = false
const ACTIVE_RIGHT_BORDER: bool = false
const ACTIVE_UP_BORDER:    bool = false
const ACTIVE_DOWN_BORDER:  bool = false

onready var borders:              Node2D = $CanvasLayer/Borders
onready var camera:               Camera2D = $Camera2D
onready var buttons:              Panel = $CanvasLayer/Buttons
onready var window_province:      Panel = $CanvasLayer/Province
onready var window_markets:       Panel = $CanvasLayer/Markets
onready var window_build_factory: Panel = $CanvasLayer/Build_factory
onready var window_production:    Panel = $CanvasLayer/Production
onready var window_parties:       Panel = $CanvasLayer/Parties
onready var window_taxes:         Panel = $CanvasLayer/Taxes
onready var window_reform:        Panel = $CanvasLayer/Reform
onready var window_population:    Panel = $CanvasLayer/Population
onready var window_research:      Panel = $CanvasLayer/Research
onready var information:          Panel = $CanvasLayer/Information
onready var window_train_army:    Panel = $CanvasLayer/Train_army
onready var window_diplomacy:     Panel = $CanvasLayer/Diplomacy
onready var window_list_of_units: ScrollContainer = $CanvasLayer/List_of_units


func _ready():
	var _err = connect("check_available_reform", window_reform, "check_available_reform")
	var _err_ = connect("research_completed", self, "research_completed")
	#hold_debate()


func research_completed(technology):
	var message = load("res://Objects/Player/Message/Message/Message.tscn").instance()
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
	

func _input(event):
	if Input.is_action_just_pressed("ui_esc"):
		get_tree().quit()
	if event.is_pressed() and not event is InputEventKey:
		if event.button_index == BUTTON_WHEEL_UP:
			if $Camera2D.zoom.x >= MIN_zoom:
				$Camera2D.zoom -= Vector2(speed_of_zoom, speed_of_zoom)
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if $Camera2D.zoom.x <= MAX_zoom:
				$Camera2D.zoom += Vector2(speed_of_zoom, speed_of_zoom)


