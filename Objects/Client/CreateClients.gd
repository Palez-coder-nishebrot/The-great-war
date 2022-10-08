extends Node

class_name CreateClients

var game
	
func create_players(game_):
	game = game_
	
	var folder: Directory = Directory.new()
	folder.open("res://Resources/StatesOnStartGame/States/")
	folder.list_dir_begin(true, true)
	
	var folder_name = folder.get_next()
	
	while folder_name != "":
		var file = load("res://Resources/StatesOnStartGame/States/" + folder_name)
		var client 
		
		if file.name_of_state == Players.country_to_start:
			client = set_player()
		else:
			client = AI.new()
		set_client(client, file)
		
		folder_name = folder.get_next()
	
	game.get_node("TileMap").create_map()
	set_gui()
	
	queue_free()
#	for name_of_country in Players.list_of_players_on_start:
#		var client
#
#		if name_of_country == Players.country_to_start:
#			client = set_player()
#		else:
#			client = load("res://Objects/AI/AI.gd").new()
#		set_client(client, name_of_country)
#
#	game.get_node("TileMap").create_map()
#	Players.player.window_parties.update()
#	set_gui()
#	queue_free()


func set_client(client, file):
	client.name_of_country = file.name_of_state
	client.national_color = file.national_color
	
	client.ideology = file.ideology
	client.capitalists_manager.player = client
	client.game = game
	client.technologies.client = client
	Players.list_of_players.append(client)
	
	client.technologies.set_technologies()
	client.military_bonuses.set_object_of_units()
	client.parties_manager.set_parties(client)


func set_player():
	var player: Object = load("res://Objects/Player/Player.tscn").instance()
	
	player.position = Vector2(2318, 2000)
	Players.player = player
	game.add_child(player)
	return player


func set_gui():
	Players.player.window_research.update_technologies()
	Players.player.window_parties.update()
