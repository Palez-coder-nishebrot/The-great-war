extends Button

export var good: String = ""

onready var parent = get_parent().get_parent().get_parent()

func _ready():
	parent.connect("update", self, "update_information")


func _gui_input(event):
	if pressed == true:
		parent.update_information_about_good(good)


func update_information(market):
	var price = market[good]
	
	if price > 0 and price < 10:
		text = str(price) + "  "
	
	elif price > 9 and price < 100:
		text = str(price) + " "
	
	else:
		text = str(price)
