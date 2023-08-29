extends Node


class_name PlayerSpawner


func spawn_client(client, state_on_start):
	if Players.country_to_start == state_on_start:
		set_player(client, state_on_start)
	else:
		set_client(client, state_on_start)
	

func set_client(client, state_on_start):
	Players.list_of_players.append(client)
	client.name_of_country = state_on_start.name_of_state
	client.national_color = state_on_start.national_color
	
	client.political_manager.set_government_form(state_on_start.government_form)
	client.political_manager.get_factories_list = Callable(client.economy_manager, "get_factories_list")
	client.game = ManagerDay.game
	client.economy_manager.set_accounting_values_func  = Callable(client.accounting_manager, "set_accounting_values")
	client.economy_manager.pay_tariffs_accounting_func = Callable(client.accounting_manager, "pay_tariffs")
	client.economy_manager.get_accounting_value_func   = Callable(client.accounting_manager, "get_accounting_value")
	client.state_on_starting = state_on_start


func set_player(client, state_on_start):
	var player: Object = preload("res://Objects/Player/Player.tscn").instantiate()
	set_client(client, state_on_start)
	
	player.client = client
	player.position = Vector2(2318, 2000)
	Players.player = player
	Players.player.client = client
	ManagerDay.game.add_child(player)
