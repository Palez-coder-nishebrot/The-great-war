extends HBoxContainer

var household

var list_education = {false: "Не образованы", true: "Образованы"}

var list_of_ideologies = [
	"Популисты",
	"Либералы",
	"Социалисты",
	"Националисты",
]

func _ready():
	$Button.text = list_education[household.education]
	$Button2.text = household.ideology
	$Button.connect("pressed", self, "change_education")
	$Button2.connect("pressed", self, "change_ideology")
	$Button2.connect("pressed", self, "set_religion")
	$Button4.connect("pressed", self, "erase_household")


func change_education():
	household.education = not household.education
	
	$Button.text = list_education[household.education]


func change_ideology():
	var ide = household.ideology
	var pos = list_of_ideologies.find(ide) + 1
	
	if pos == 4: pos = 0
	
	household.ideology = list_of_ideologies[pos]
	
	$Button2.text = household.ideology


func set_religion():
	pass


func erase_household():
	get_parent().get_parent().erase_household(household)
