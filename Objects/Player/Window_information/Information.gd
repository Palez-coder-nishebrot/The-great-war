extends Panel

var show_resourses: bool = false

onready var game = get_parent().get_parent().get_parent()

const day_of_week: Dictionary = {
	1: "Понедельник",
	2: "Вторник",
	3: "Среда",
	4: "Четверг",
	5: "Пятница",
	6: "Суббота",
	7: "Воскресенье",
}

const month_of_year: Dictionary = {
	1:  "Января",
	2:  "Февраля",
	3:  "Марта",
	4:  "Апреля",
	5:  "Мая",
	6:  "Июня",
	7:  "Июля",
	8:  "Августа",
	9:  "Сентября",
	10: "Октября",
	11: "Ноября",
	12: "Декабря",
}

const pause_of_game: Dictionary = {
	true:  "Возобновить",
	false: "Пауза"
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
	$VBoxContainer/Label3.text = "Казна: " + str(Players.player.economy["Кроны"])


func check_GDP():
	$VBoxContainer/Label4.text = "ВВП: " + str(Players.player.economy["ВВП"])


func check_resourses():
	show_resourses = not show_resourses
	
	if show_resourses == false:
		hide_resourses()

	else:
		show_resourses()


func update_pause():
	game.pause = not game.pause
	$VBoxContainer/Button_pause.text = pause_of_game[game.pause]


func show_resourses():
	$VBoxContainer/Button.text = "Скрыть ресурсы"
	for player in Players.list_of_players:
		for tile in player.list_of_tiles:
			tile.show_resourses()


func hide_resourses():
	$VBoxContainer/Button.text = "Показать ресурсы"
	for player in Players.list_of_players:
		for tile in player.list_of_tiles:
			tile.hide_resourses()


func change_speed_of_game():
	game.speed_of_game = speed_of_game[game.speed_of_game]
	$VBoxContainer/Button_speed.text = "Скорость: " + str(game.speed_of_game)
