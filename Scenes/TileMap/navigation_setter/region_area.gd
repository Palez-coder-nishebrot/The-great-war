extends Area2D





func _on_area_entered(area):
	get_parent().add_neighbors(area.get_parent())
	pass # Replace with function body.
