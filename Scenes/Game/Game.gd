extends Node2D

@onready var tilemap = $TileMap

var time_of_game: Dictionary = {
	day   = 1,
	month = 1,
	year  = 1914,
}

var list_of_speed_of_game: Dictionary = {
	"Медленно": 1.0,
	"Нормально": 0.8,
	"Быстро": 0.6,
	"Очень быстро": 0.4,
}


var speed_of_game: float = 1.0
var pause:         bool  = false
var list_of_regions:   Array = []


func _ready():
	SceneStorage.timer.get_data_func = Callable(get_node("DataManager"), "get_data")
	SceneStorage.timer.game_new_day_func = Callable(self, "new_day_started")
	TranslationServer.set_locale("en")
	ManagerDay.game = self
	
	tilemap.create_map()
	SceneStorage.timer.register_timer(get_node("GlobalTimer"))


func new_day_started():
	ManagerDay.emit_signal("clear_accounting")
	ManagerDay.emit_signal("clear_markets")
	ManagerDay.update_economy()
	
	ManagerDay.update_information_in_GUI()
