extends Node

const tipe = "process"

var building: Object
var game:     Object

func start_build_factory(list):
	var time = 0
	
	while time != building.time:
		yield(game, "new_day")
		time = time + 1
	
	list.append(building)
	
	list.erase(self)
	queue_free()

