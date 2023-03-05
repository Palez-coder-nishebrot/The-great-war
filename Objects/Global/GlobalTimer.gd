extends Timer

class_name GlobalTimer

var game_speed: float = 1.0


func _init():
	var _err = connect("timeout", self, "update")
	#start(game_speed)


func update():
	start(game_speed)
