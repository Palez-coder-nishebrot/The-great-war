extends HBoxContainer

var household

var list_education = {
	"Рабочий": 20,
	"Фабричный рабочий": 50,
	"Ремесленник": 80,
}

var list_of_soc_classes: Array = [
	"Рабочий",
	"Фабричный рабочий",
	"Ремесленник",
]

func _ready():
	$SocClass.text = household.soc_class
	

func set_soc_class():
	var soc_class = household.soc_class
	
	var pos = list_of_soc_classes.find(soc_class) + 1
	
	if pos == 3: pos = 0
	
	household.soc_class = list_of_soc_classes[pos]
	household.education = list_education[household.soc_class]
	_ready()


func erase_household():
	get_parent().get_parent().erase_household(household)
