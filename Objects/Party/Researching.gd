extends Node

var technology: Dictionary = {
	button             = null,
	technology         = null,
	tipe_of_technology = null,
}

var perc: float
var game
var player

var max_day = 3
var day = 0

func start():
	
	while day != max_day:
		yield(game, "new_day")
		day = day + 1
		send_info(day)
	
	player.researching_object = null
	Research.research_completed(technology, Players.player)
	queue_free()


func send_info(day):
	if player.get_groups()[1] == "Human":
		player.window_research.get_node("Label").text = technology.technology + "(ост. " + str(max_day - day) + "дн.)"
