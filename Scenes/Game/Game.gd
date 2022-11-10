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
var list_of_provinces:   Array = []
#var list_of_soc_classes: Array = []

var purchase_manager: Object = load("res://Objects/Global/Managers/ManagerPurchase.gd").new()
var factory_manager: Object = load("res://Objects/Global/Managers/ManagerFactory.gd").new()
var craftsmen_manager: Object = load("res://Objects/Global/Managers/MaganerCraftsmen.gd").new()
var population_manager: Object = load("res://Objects/Global/Managers/ManagerPopulation.gd").new()

func _ready():
	TranslationServer.set_locale("en")
	ManagerDay.game = self
	set_prices_of_goods()
	
	if Players.country_to_start == "Редактор_провинций":
		create_province_editor()
	else:
		var manager = CreateClients.new()
		manager.create_players(self)
	craftsmen_manager.game = self
	craftsmen_manager.set_purchase()


func set_prices_of_goods():
	for i in GlobalMarket.prices_of_goods:
		if GlobalMarket.list_of_resourses.has(i):
			GlobalMarket.prices_of_goods[i] = GlobalMarket.min_and_max_prices_of_goods[i].min_
		else:
			GlobalMarket.prices_of_goods[i] = int((GlobalMarket.min_and_max_prices_of_goods[i].min_ * 1.5))


func new_day():
	yield(get_tree().create_timer(speed_of_game), "timeout")
	
	if pause == false:
		update_data()
		circle_of_game()
		Players.player.information.check_data(time_of_game.day,time_of_game.month, 
		time_of_game.year)
		emit_signal("new_day")
		
	new_day()
	

func update_data():
	time_of_game.day += 1
	if time_of_game.day == 31:
		time_of_game.month += 1
		time_of_game.day = 1
	if time_of_game.month == 13:
		time_of_game.year += 1
		time_of_game.month = 1


func circle_of_game():
	ManagerDay.update_accounting() # Обнулить учет расходов и доходов
	
	ManagerDay.update_clients() #Финансирование школ, прироста населения обновление реваншизма, военной усталости
	
	ManagerDay.population_pays_taxes()

	ManagerDay.update_economy()
	
	ManagerDay.update_information_in_GUI()
	
	GlobalMarket.update_prices(time_of_game.day)
	
	clear_GDP()


func clear_GDP():
	for player in Players.list_of_players:
		player.gdp = 0


func spawn_household(province):
	province.population_manager.new_generation = 0
	province.population_manager.quantity_of_workers += 1
#	var household = Household.new()
#	household.province = province
#	household.education = 0
#	household.soc_class = "Worker"
#	household.religion = ""
#
#	province.player.list_of_soc_classes.append(household)
#	household.population_manager = province.population_manager
#	province.population_manager.list_of_soc_classes.append(household)
#	province.population_manager.list_of_workers.append(household)
#	province.population_manager.new_generation = 0
	
	province.population_manager.needs.set_needs(province.population_manager)
	
	
	
func create_province_editor():
	var human = load("res://Objects/ProvinceEditor/ProvinceEditor.tscn").instance()
	add_child(human)
	Players.player = human
	set_provinces()


func set_provinces():
	for i in $TileMap.get_children():
		if i.get_class() == "Node2D":
			i.start()
