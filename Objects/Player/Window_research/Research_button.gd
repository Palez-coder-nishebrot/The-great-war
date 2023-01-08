extends Button 

var technology: Technology

var available: bool = false

var level: int
var parent: Object


func _ready():
	var _err = connect("pressed", self, "button_pressed")
	

func button_pressed():
	parent.show_technology(self)
