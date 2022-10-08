extends Button


var good


func _ready():
	connect("pressed", self, "button_pressed")

func button_pressed():
	if good != null:
		get_parent().erase_resource(good)
