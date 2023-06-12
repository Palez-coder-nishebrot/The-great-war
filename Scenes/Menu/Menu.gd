extends Node2D


func _ready():
	TranslationServer.set_locale("en")


func ChangeScene(name_of_country):
	Players.country_to_start = name_of_country
	var _err = get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")


func one_player():
	hide_cont()
	$ScrollContainer.visible = true
	$VBoxContainer2.visible = true


func multiplayer_():
	hide_cont()
	

func developer_guide():
	var _err = get_tree().change_scene_to_file("res://Scenes/DeveloperGuide/DeveloperGuide.tscn")
	
	
func hide_cont():
	$VBoxContainer.visible = false
	$Label2.visible        = false


func path_editor():
	var _err = get_tree().change_scene_to_file("res://Scenes/MapEditor/MapEditor.tscn")
