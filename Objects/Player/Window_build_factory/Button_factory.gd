extends Button

var parent: Object 

func _ready():
	connect("pressed", self, "on_button_pressed")


func on_button_pressed():
	parent.check_factory(text)
