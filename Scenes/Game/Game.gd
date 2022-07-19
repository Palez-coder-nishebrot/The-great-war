extends Node2D

signal new_day

var time_of_game: Dictionary = {
	day   = 1,
	month = 1,
	year  = 1905,
}

var list_of_speed_of_game: Dictionary = {
	"Медленно": 1.0,
	"Нормально": 0.8,
	"Быстро": 0.6,
	"Очень быстро": 0.4,
}


var speed_of_game: float = 1.0
var pause:         bool  = false
var list_of_privinces: Array = []
var list_of_soc_classes: Array = []

var purchase_manager: Object = load("res://Objects/Global/ManagerPurchase.gd").new()
var factory_manager: Object = load("res://Objects/Global/ManagerFactory.gd").new()

func _ready():
	#GlobalMarket.update_prices()
	create_players()
	

func create_players():
	var player: Object
	var _player_: Object
	
	player = load("res://Objects/Player/Player.tscn").instance()
	player.position = Vector2(2318, 2000)
	player.name_of_country = Players.country_to_start
	player.national_color  = Players.list_of_players_on_start[player.name_of_country]["Цвет"]
	Players.player = player
	create_parties(player)
	Players.list_of_players.append(player)
	_player_ = player
	add_child(player)
	
	for name_of_country in Players.list_of_players_on_start:
		if name_of_country != _player_.name_of_country:
			player = load("res://Objects/AI/AI.gd").new()
			player.name_of_country = name_of_country
			player.national_color  = Players.list_of_players_on_start[name_of_country]["Цвет"]
			Players.list_of_players.append(player)
			
			create_parties(player)
	
	$TileMap.create_map()
	Players.player.window_parties.update()


func create_parties(player):
	var ideologies = load("res://Objects/Global/Ideologies.gd").new()
	for ideology in ideologies.ideologies:
		var party = Functions.create_party(player, ideology, ideologies)
		
		if party.ideology == Players.list_of_players_on_start[player.name_of_country]["Идеология"]:
			player.policy["Правящая_партия"] = party


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
	
	#school_funding() #Финансирование школ
	
	start_resourse_extraction()

	factory_manager.make_goods() # Производство товаров фабриками

	factory_manager.buy_purchase() # Купить сырье для фабрик

	purchase_manager.meet_the_needs() # Купить товары для населения
	
	GlobalMarket.export_goods_from_local_markets()
	
	GlobalMarket.update_prices()
	
	Players.player.information.check_GDP()
	
	clear_GDP()
	
	Players.player.window_markets.update_information()
	
	Players.player.window_production.update_information()
	#Players.player.window_population.update_information()
	
	GlobalMarket.clear_export_and_import()
	GlobalMarket.clear_supply_and_demand()


func clear_GDP():
	for player in Players.list_of_players:
		player.economy["ВВП"] = 0


func start_resourse_extraction():
	purchase_manager.resourse_extraction(self)
		
		
func make_goods():
	for i in list_of_privinces:
		for y in i.list_of_buildings:
			if y.tipe == "factory" and y.closed == false:
				y.make_goods()


func buy_goods_for_factory():
	for i in list_of_privinces:
		for y in i.list_of_buildings:
			if y.tipe == "factory" and y.closed == false:
				y.buy_purchase()


func school_funding():
	for i in Players.list_of_players:
		#var cost = i.economy["Финансирование_школ"]
		#cost = cost * (i.list_of_tiles.size() * 8)
		#i.economy["Кроны"] = i.economy["Кроны"] - cost
		
		increase_literate_population(i)

func increase_literate_population(player):
	
	pass
