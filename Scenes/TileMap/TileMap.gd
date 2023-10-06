extends Node2D


@onready var game: Node2D = get_parent()


func create_map():
	set_clients()
	SceneStorage.regions_manager.province_loader.create_map(SceneStorage.regions_manager.regions_list)
	get_node("navigation_setter").start()


func set_clients():
	for client in get_children():
		if client is Client:
			client.state_on_start.player_spawner.spawn_client(client, client.state_on_start)
			
			for region in client.get_children():
				region.client_owner = client
				region.set_new_owner(client)
	print("spawning clients and give_tiles_to_players finished")
