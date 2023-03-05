extends Node

signal field_updated

var camera
var timer              = GlobalTimer.new()
var population_manager = PopulationWorldManager.new()


func await_field(var_name, callback = null):
	while get(var_name) == null:
		yield(self, "field_updated")
	
	if callback != null and callback is FuncRef:
		callback.call_func(get(var_name))
	
	return get(var_name)


func set_field(var_name, value):
	set(var_name, value)
	emit_signal("field_updated")


func update_game_time():
	pass
