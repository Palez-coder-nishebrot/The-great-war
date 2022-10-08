extends Button 

var technology: Technology

var available: bool = false

var level: int
var parent: Object


func _ready():
	connect("pressed", self, "button_pressed")
	

func button_pressed():
	parent.show_technology(self)
