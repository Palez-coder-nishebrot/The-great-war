extends Button


func _ready():
	connect("pressed", self, "button_pressed")
	

func button_pressed():
	queue_free()
	pass
