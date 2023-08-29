extends Node2D

signal new_day

@onready var tilemap      = $TileMap
@onready var data_manager = $DataManager


var speed_of_game: float = 0.8
var pause:         bool  = false
var list_of_regions:   Array = []


func _init():
	SceneStorage.game = self


func _ready():
	SceneStorage.timer.get_data_func = Callable(get_node("DataManager"), "get_data")
	SceneStorage.timer.game_new_day_func = Callable(self, "new_day_started")
	TranslationServer.set_locale("en")
	ManagerDay.game = self
	
	tilemap.create_map()
	SceneStorage.timer.register_timer(get_node("GlobalTimer"))


func new_day_started():
	emit_signal("new_day")
	ManagerDay.emit_signal("clear_accounting")
	ManagerDay.emit_signal("clear_markets")
	ManagerDay.update_economy()
	
	ManagerDay.update_information_in_GUI()
