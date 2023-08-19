extends Node2D

@onready var game_name_label: Label           = $game_name
@onready var countries_list:  ScrollContainer = $ScrollContainer
@onready var main_buttons:    VBoxContainer   = $VBoxContainer


func _ready():
	TranslationServer.set_locale("en")


func ChangeScene(state):
	Players.country_to_start = state
	var _err = get_tree().change_scene_to_file("res://Scenes/Game/Game.tscn")


func one_player():
	hide_cont()
	countries_list.visible = true
	

func developer_guide():
	var _err = get_tree().change_scene_to_file("res://Scenes/DeveloperGuide/DeveloperGuide.tscn")
	
	
func hide_cont():
	main_buttons.visible  = false
	game_name_label.visible = false


func exit_game():
	get_tree().quit()
