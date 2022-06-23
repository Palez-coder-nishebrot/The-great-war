extends Button


onready var num:    int    = int(text.split(text[-1])[0])
onready var parent: Object = get_parent().get_parent().get_parent().get_parent()

func _ready():
	connect("pressed", self, "on_button_pressed")

func on_button_pressed():
	parent.change_tax(parent.list_of_containers[get_parent()], num)
