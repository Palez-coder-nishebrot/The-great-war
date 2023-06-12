extends Node

class_name GlobalTimer

signal game_resumed

var game_speed: float = 1.0
var pause:      bool = false
var timer:      Timer

var data_manager_new_day_func#: FuncRef
var game_new_day_func#:         FuncRef
var get_data_func#:             FuncRef


func register_timer(timer_):
	print("register_timer")
	timer = timer_
	timer.connect("timeout", Callable(self, "new_day"))
	timer.start(game_speed)


func new_day():
	if pause == false:
		data_manager_new_day_func.call()
		game_new_day_func.call()
	
	timer.start(game_speed)


func set_pause(value):
	pause = value


func check_pause():
	if pause == true:
		return "pause"
	else:
		return "resume"


func get_data():
	return get_data_func.call()
