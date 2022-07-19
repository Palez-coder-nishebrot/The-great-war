extends Button


var cotegory: String

var result: Dictionary
var name_of_button: String

func _ready():
	connect("mouse_entered", self, "mouse_entered")
	connect("mouse_exited", self, "mouse_exited")
	connect("pressed", self, "on_button_pressed")
	name_of_button = text
	pass
	

func mouse_entered():
#	for i in result:
#		if cotegory != "Максимальный рабочий день" and cotegory != "Государственное образование":
#			text = cotegory + ": +" + str(result[i]) + "%"
#
#		elif cotegory == "Государственное образование":
#			text = "Гос. образование" + ": +" + str(result[i]) + "%"
#
#		else:
#			text = "Произв. фабрик: " + str(result[i]) + "%"
	pass

func mouse_exited():
	text = name_of_button


func on_button_pressed():
	pass
