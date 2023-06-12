extends Button

@onready var parent = get_parent().get_parent()

func _ready():
	var _err = connect("pressed", Callable(self, "button_pressed"))
	

func button_pressed():
	if parent.province.training_units == null:
		parent.show_information_about_unit(text)

