extends Button


func _ready():
	connect("pressed", self, "pressed")


func pressed():
	get_parent().on_button_pressed(self)
