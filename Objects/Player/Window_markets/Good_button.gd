extends Button

var good: String = ""

func _ready():
	good = name
	get_parent().get_parent().get_parent().connect("update", self, "update_information")
	connect("pressed", self, "button_pressed")


func button_pressed():
	get_parent().get_parent().get_parent().update_information_about_good(good)


func update_information(market):
	text = str(market[good])
