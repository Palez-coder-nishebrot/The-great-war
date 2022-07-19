extends Node2D

var list_of_texts: Dictionary = {
	"Экономика": "res://Text/Economy.txt",
	"Население": "res://Text/Population.txt",
	"Проблемы мультиплеера: Player.player": "res://Text/Problems of multiplayer.txt",
	"Структура игры": "res://Text/Game structure.txt",
}


func _ready():
	for i in $VBoxContainer.get_children():
		i.connect("pressed", i, "on_button_pressed")
		

func open_file(path):
	var text = File.new()
	text.open(path, File.READ)
	var text_of_file = text.get_as_text()
	text.close()
	$RichTextLabel.text = text_of_file


func exit():
	get_tree().change_scene("res://Scenes/Menu/Menu.tscn")
