extends Node


var country_to_start: StateOnStartGame
var player:           Object


var list_of_players:  Array = []


func find_client(name_of_state):
	for i in list_of_players:
		if i.name_of_country == name_of_state:
			return i


func get_player_client():
	return player.client


func get_player():
	return player
