extends Node


class_name TechnologyBranch


var branch_levels: Array[Technology] = []
var level: int = -1


func _init(path: String):
	for i in range(5):
		branch_levels.append(load(path + "0" + str(i + 1) + ".tres"))


func level_up():
	level += 1


func activate_effects(client):
	var tech = branch_levels[level]
	tech.activate_effects(client)
