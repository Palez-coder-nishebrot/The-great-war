extends Node2D

signal new_day

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

var purchase_manager: Object = load("res://Objects/Global/Managers/ManagerPurchase.gd").new()
var factory_manager: Object = load("res://Objects/Global/Managers/ManagerFactory.gd").new()

var country_rating_by_selling_goods: Dictionary = {}


func _ready():
	SceneStorage.timer.get_data_func = Callable(get_node("DataManager"), "get_data")
	SceneStorage.timer.game_new_day_func = Callable(self, "new_day_started")
	TranslationServer.set_locale("en")
	ManagerDay.game = self
	
	var manager = CreateClients.new()
	manager.create_players(self)
	get_node("TileMap").create_map()
	SceneStorage.timer.register_timer(get_node("GlobalTimer"))


func set_rating():
	var path: String = "res://Resources/Good/"
	var folder = DirAccess.open(path)
	var _err_ = folder.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	var file = folder.get_next()
	
	while file != "":
		if file != "good.gd":
			var fle = load(path + file)
			country_rating_by_selling_goods[fle]


func new_day_started():
	ManagerDay.emit_signal("clear_markets")
#	ManagerDay.clear_accounting() # Обнулить учет расходов и доходов
#	ManagerDay.update_clients() #Финансирование школ, прироста населения обновление реваншизма, военной усталости
#	ManagerDay.population_pays_taxes()
	ManagerDay.update_economy()
	ManagerDay.update_information_in_GUI()
