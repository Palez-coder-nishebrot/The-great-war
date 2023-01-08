extends Button


func _ready():
	var _err = connect("pressed", self, "button_pressed")
	

func button_pressed():
	queue_free()
	pass
