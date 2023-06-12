extends Node


var storage_good: RefCounted


func mouse_entered():
	if storage_good != null:
		var panel = Functions.create_details_panel(self)
		panel.show_raw(storage_good, get_parent().get_parent().factory)
