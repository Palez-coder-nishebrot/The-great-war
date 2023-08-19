extends Node


class_name ExpansionProject

const effect: int = 500

var building: Object
var game:     Object
var time     = 0
var max_time = 3


func _init(building_, game_):
	self.building = building_
	self.game     = game_
	

func start_factory_expansion():
	
	while time != max_time:
		await ManagerDay.check_projects
		time = time + 1
	
	building.max_employed_number      += effect
	building.real_max_employed_number += effect
	
	building.expansion_project = null
	
