extends Area2D

var player: Object

@onready var name_of_player = name

func _ready():
	connect("area_shape_entered", Callable(self, "tile_entered"))


func tile_entered(area_rid, area, area_shape_index, local_shape_index):
	var tile = area.get_parent()
	
	if tile != get_parent():
		tile.player = player
		tile.label.text = name
		
		player.list_of_tiles.append(tile)


func find_object_of_player():
	for i in Players.list_of_players:
		if i.name_of_country == name:
			player = i
