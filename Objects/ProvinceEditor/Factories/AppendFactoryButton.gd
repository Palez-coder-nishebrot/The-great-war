extends Button

export var good = ""


func _gui_input(event):
	if pressed == true:
		button_pressed()


func button_pressed():
	get_parent().append_factory_to_tile(good)