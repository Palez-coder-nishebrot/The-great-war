extends Node

const tipe = "process"

var building: Object
var game:     Object
var name_of_factory: String
var time = 0

func start_build_factory(list):
	name_of_factory = building.name_of_factory
	
	while time != building.time:
		yield(game, "new_day")
		time = time + 1
	
	list.append(building)
	game.factory_manager.list_of_factories.append(building)
	
	building.province.get_goods_in_province()
	building.closed = false
	
	list.erase(self)
	queue_free()
