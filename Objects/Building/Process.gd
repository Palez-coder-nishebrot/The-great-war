extends Node

const tipe = "process"

var building: Object
var game:     Object
var time = 0

func start_build_factory(list):
	
	while time != building.time:
		yield(game, "new_day")
		time = time + 1
	
	list.append(building)
	
	building.province.get_goods_in_province()
	
	list.erase(self)
	queue_free()
	get_parent().factory_manager.list_of_factories.append(building)
