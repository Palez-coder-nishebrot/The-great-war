extends Panel


var levels: Dictionary = {
	"Фабричное производство":  0,
	"Фермерское производство": 0,
	"Добыча":                  0,
	"Инфраструктура":          0,
	
	"Управление армией":       0,
	"Техника":                 0,
	"Тяжелое вооружение":      0,
	"Легкое вооружение":       0,
}

func _ready():
	var cotegory_
	for container in get_children():
		for cotegory in container.get_children():
			for element in cotegory.get_children():
				if element.get_class() == "Button":
					if levels[cotegory_] != int(element.name[-1]):
						element.disabled = true
				
				else:
					cotegory_ = element.text
			
	pass


