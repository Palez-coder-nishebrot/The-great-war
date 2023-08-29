extends RefCounted

class_name ReformCotegory


signal reform_is_carried


var reform: Reform
var level:  int = 0
var max_level: int = 0


func _init(rfrm: Reform):
	reform    = rfrm
	max_level = reform.levels.size() - 1


func to_reform(client):
	set_reform_effects(client, 1)


func roll_back_reform(client):
	set_reform_effects(client, -1)
	

func set_reform_effects(client, num):
	var previous_level = reform.levels[level]
	level             += num
	var next_level     = reform.levels[level]
	
	previous_level.deactivate_effects(client)
	next_level.activate_effects(client)
	emit_signal("reform_is_carried")
