extends Button

var good

func _gui_input(event):
	if pressed == true:
		if good != null:
			get_parent().erase_factory(good)
			


