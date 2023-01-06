extends Reference

var tile
var collide_with_tile = []

func _on_navigation_tile_monitor(type, _rid, instance_id, _sh1, _sh2):
	if not Physics2DServer.AREA_BODY_ADDED == type:
		return
	
	#collide_with_tile.append(instance_from_id(instance_id).tile)
	
	tile.call_deferred("add_debug_nav_line", instance_from_id(instance_id).tile)
	
#	if tile.name == "Галич":
#		print("from: ", tile.name, " to: ", instance_from_id(instance_id).tile.name)
