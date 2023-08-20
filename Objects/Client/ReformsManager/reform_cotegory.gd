extends RefCounted

class_name ReformCotegory


var reform: Reform
var level:  int = 0
var max_level: int = 0


func _init(rfrm):
	reform    = rfrm
	max_level = reform.levels.size() - 1
