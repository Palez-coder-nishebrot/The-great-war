extends Button 

var tipe_of_technology: String
var technology: String = text

var level: int
onready var parent = get_parent().get_parent().get_parent()


func _ready():
	connect("pressed", self, "button_pressed")
	

func button_pressed():
	parent.show_technology(self)
