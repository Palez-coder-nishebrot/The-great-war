extends HBoxContainer

var household

var list_education = {false: "Не образованы", true: "Образованы"}

var list_of_soc_classes: Array = [
	"Рабочий",
	"Фабричный рабочий",
	"Ремесленник",
]

func _ready():
	$Education.text = list_education[household.education]
	$SocClass.text = household.soc_class


func change_education():
	household.education = not household.education
	
	$Education.text = list_education[household.education]


func set_soc_class():
	var soc_class = household.soc_class
	
	var pos = list_of_soc_classes.find(soc_class) + 1
	
	if pos == 3: pos = 0
	
	household.soc_class = list_of_soc_classes[pos]
	
	_ready()


func erase_household():
	get_parent().get_parent().erase_household(household)
