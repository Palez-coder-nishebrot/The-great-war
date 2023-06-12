extends RefCounted

class_name CreateClients

var game
var player = load("res://Objects/Player/Player.tscn").instantiate()


func create_players(game_):
	game = game_
	
	var folder: DirAccess = DirAccess.open("res://Resources/StatesOnStartGame/States/")
	var _err_ = folder.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	
	var folder_name = folder.get_next()
	
	while folder_name != "":
		var file = load("res://Resources/StatesOnStartGame/States/" + folder_name)
		
		if file.name_of_state == Players.country_to_start:
			set_player(file)
		else:
			var client = AI.new()
			set_client(client, file)
		
		folder_name = folder.get_next()
	print("players created")
	set_gui()


func set_client(client, file):
	Players.list_of_players.append(client)
	client.name_of_country = file.name_of_state
	client.national_color = file.national_color
	
	client.political_manager.set_government_form(file.government_form)
	client.political_manager.set_parties(file.ideology)
	client.political_manager.get_factories_list = Callable(client.economy_manager, "get_factories_list")
	client.game = game
	client.economy_manager.set_accounting_values_func = Callable(client.accounting_manager, "set_accounting_values")


func set_player(file):
	var player: Object = preload("res://Objects/Player/Player.tscn").instantiate()
	set_client(player, file)
	
	player.position = Vector2(2318, 2000)
	Players.player = player
	game.add_child(player)


func set_gui():
	Players.player.window_research.update_technologies()
	Players.player.window_parties.update()
