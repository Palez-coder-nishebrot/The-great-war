extends Panel

@onready var game = get_parent().get_parent().get_parent()
@onready var data_label = $Panel/Label2


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
	0.8: 0.6,
	0.6: 0.4,
	0.4: 0.2,
	0.2: 0.8,
}

func _ready():
	$VBoxContainer/Label.text = Players.get_player_client().name_of_country


func update_info():
	check_data()


func check_data():
	var data = SceneStorage.timer.get_data()
	data_label.text = str(data[0]) + " " + month_of_year[data[1]] + " " + str(data[2]) + " год"


func update_pause():
	var timer = SceneStorage.timer
	timer.set_pause(not timer.pause)
	$VBoxContainer/Button_pause.text = timer.check_pause()


func change_speed_of_game():
	game.speed_of_game = speed_of_game[game.speed_of_game]
	SceneStorage.timer.game_speed = game.speed_of_game
	$VBoxContainer/Button_speed.text = "Скорость: " + str(game.speed_of_game)
