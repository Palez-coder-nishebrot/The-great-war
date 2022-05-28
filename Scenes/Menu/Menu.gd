extends Node2D

#func _ready():
#	push_warning("Check!)")


func ChangeScene(name_of_country):
	Players.country_to_start = name_of_country
	get_tree().change_scene("res://Scenes/Game/Game.tscn")
	


