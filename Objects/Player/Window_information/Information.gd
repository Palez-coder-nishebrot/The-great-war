extends Panel

var showing_map: int = 0
var showing_good: String = "coal"

onready var game = get_parent().get_parent().get_parent()

const showing_map_list: Dictionary = {
	0: "show_name_of_region",
	1: "show_units",
	2: "show_resources",
}

const day_of_week: Dictionary = {
	1: "Monday",
	2: "Tuesday",
	3: "Wednesday",
	4: "Thursday",
	5: "Friday",
	6: "Saturday",
	7: "Sunday",
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

const pause_of_game: Dictionary = {
	true:  "Resume",
	false: "Pause"
}

const speed_of_game: Dictionary = {
	1.5: 1.0,
	1.0: 0.8,
	0.8: 0.5,
	0.5: 1.5,
}

func _ready():
	$VBoxContainer/Label.text = Players.player.name_of_country


func check_data(day, month, year):
	$Label2.text = str(day) + " " + month_of_year[month] + " " + str(year) + " год"


func check_GDP():
	$VBoxContainer/Label4.text = "ВВП: " + str(Players.player.gdp)


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
	game.pause = not game.pause
	$VBoxContainer/Button_pause.text = pause_of_game[game.pause]


func change_speed_of_game():
	game.speed_of_game = speed_of_game[game.speed_of_game]
	$VBoxContainer/Button_speed.text = "Скорость: " + str(game.speed_of_game)
