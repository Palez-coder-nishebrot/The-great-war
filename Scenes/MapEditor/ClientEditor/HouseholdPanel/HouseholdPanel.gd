extends HBoxContainer

var household
var parent

@onready var soc_class_button = $SocClass
@onready var delete_button = $Delete

var list_of_soc_classes: Array = [
	"Worker",
	"Proletarian",
	"Craftsman",
	"Clerk",
]

func change_soc_class():
	var count = list_of_soc_classes.find(household.soc_class) + 1
	if list_of_soc_classes.size() < count + 1:
		count = 0
	household.soc_class = list_of_soc_classes[count]
	soc_class_button.text = list_of_soc_classes[count]


func erase_soc_class():
	parent.region.list_of_households.erase(household)
	queue_free()
