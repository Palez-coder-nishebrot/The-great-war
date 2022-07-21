extends Button

var province

func _ready():
	connect("pressed", self, "on_button_pressed")


func on_button_pressed():
	get_parent().get_parent().get_parent().erase_province(province, "paths_of_provinces")
