extends Button

onready var parent = get_parent().get_parent()

var available = true

func _ready():
	connect("pressed", self, "button_pressed")
	

func button_pressed():
	parent.show_information_about_unit(text)
	#parent.show_technology(self)

