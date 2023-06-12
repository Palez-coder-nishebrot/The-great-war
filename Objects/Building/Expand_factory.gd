extends Node


var building: Object
var game:     Object
var time     = 0
var max_time = 3

func start_expansion_of_factory():
	
	while time != max_time:
		await game.new_day
		time = time + 1
	
	building.max_employed_number += 1
	building.real_max_employed_number += 1
	
	
	building.expansion = null
	
	queue_free()
