extends Button

export var window: String = ""

func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		get_parent().get_parent().on_button_pressed(window)

