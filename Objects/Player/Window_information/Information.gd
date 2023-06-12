extends Panel

var showing_map: int = 0
var showing_good: Resource = load("res://Resources/Good/oil.tres")

@onready var game = get_parent().get_parent().get_parent()
@onready var data_label = $Panel/Label2


const showing_map_list: Dictionary = {
	0: "set_default_region",
	1: "show_units",
	2: "show_resources",
}

const month_of_year: Dictionary = {
	1:  "January",
	2:  "February",
	3:  "March",
	4:  "April",
	5:  "May",
	6:  "June",
	7:  "July",
	8:  "August",
	9:  "September",
	10: "October",
	11: "November",
	12: "December",
}

const speed_of_game: Dictionary = {
	1.5: 1.0,
	1.0: 0.8,
	0.8: 0.5,
	0.5: 1.5,
}

func _ready():
	$VBoxContainer/Label.text = Players.player.name_of_country


func update_info():
	check_data()


func check_data():
	var data = SceneStorage.timer.get_data()
	data_label.text = str(data[0]) + " " + month_of_year[data[1]] + " " + str(data[2]) + " год"


func settings_for_showing_map():
	showing_map += 1
	if showing_map == 3:
		showing_map = 0
	$Goods.visible = showing_map == 2


func change_showing_map():
	settings_for_showing_map()
	set_showing_map()
	$VBoxContainer/EconomyOrPolicy.text = showing_map_list[showing_map]


func set_showing_map():
	for i in Players.player.game.list_of_provinces:
		i.set_default_region()
		i.call(showing_map_list[showing_map])


func update_pause():
	var timer = SceneStorage.timer
	timer.set_pause(not timer.pause)
	$VBoxContainer/Button_pause.text = timer.check_pause()


func change_speed_of_game():
	game.speed_of_game = speed_of_game[game.speed_of_game]
	$VBoxContainer/Button_speed.text = "Скорость: " + str(game.speed_of_game)
