extends Node2D

#func _ready():
#	var text = "Hello World!"
#	text.erase(3, 2)
#	print(text)
#	push_warning("Check!")


func ChangeScene(name_of_country):
	Players.country_to_start = name_of_country
	get_tree().change_scene("res://Scenes/Game/Game.tscn")
	


