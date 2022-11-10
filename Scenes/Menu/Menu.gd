extends Node2D


func _ready():
	var s = 120.0
	var d = 100.0
			
	print(((s / d) * 100) - 100)
	
	TranslationServer.set_locale("en")
	ReformEffect
	

func ChangeScene(name_of_country):
	Players.country_to_start = name_of_country
	get_tree().change_scene("res://Scenes/Game/Game.tscn")
	

func one_player():
	hide()
	$ScrollContainer.visible = true
	$VBoxContainer2.visible = true

func multiplayer_():
	hide()
	

func developer_guide():
	get_tree().change_scene("res://Scenes/DeveloperGuide/DeveloperGuide.tscn")
	
	
func hide():
	$VBoxContainer.visible = false
	$Label2.visible        = false


func path_editor():
	get_tree().change_scene("res://Scenes/MapEditor/MapEditor.tscn")
