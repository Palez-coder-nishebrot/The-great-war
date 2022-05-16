extends Button

var good: String = ""

func _ready():
	good = text
	get_parent().get_parent().get_parent().connect("update", self, "update_information")


func update_information(market):
	text = good + ": " + str(market[good])
