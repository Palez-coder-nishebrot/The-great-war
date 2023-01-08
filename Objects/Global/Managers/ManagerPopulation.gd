extends Node

func new_day(_data):
#	if data.day == 1:
		for client in Players.list_of_players:
			for region in client.list_of_tiles:
				breakpoint
