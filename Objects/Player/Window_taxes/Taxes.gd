extends Panel

onready var economy = Players.player.economy

onready var list_of_containers: Dictionary = {
	$VBoxContainer/HBoxContainer: "Налоги_на_бедных",
	$VBoxContainer/HBoxContainer2: "Налоги_на_богатых",
	$VBoxContainer/HBoxContainer3: "Пошлины",
}

var list_of_bool: Dictionary = {
	true: "Да",
	false: "Нет"
}


func _ready():
	update()


func update():
	find_button($VBoxContainer/HBoxContainer.get_children(), economy["Налоги_на_бедных"])
	find_button($VBoxContainer/HBoxContainer2.get_children(), economy["Налоги_на_богатых"])
	find_button($VBoxContainer/HBoxContainer3.get_children(), economy["Пошлины"])
	
	$VBoxContainer/Label4.text = economy["Экономическая_модель"]
	$VBoxContainer/Label5.text = economy["Торговая_политика"]
	$VBoxContainer/Label6.text = "Цена на фабрики: " + str(economy["Цена_на_фабрики"]) + "%"
	$VBoxContainer/Label7.text = "Субсидирование: " + list_of_bool[economy["Субсидирование"]]
	$VBoxContainer/Label8.text = "Доходы фабрикантов: " + str(economy["Доходы_фабрикантов"])
	

func find_button(children, num):
	for i in children:
		var num_ = i.text.split(i.text[-1])[0]
		if int(num_) == num:
			i.disabled = true
		else:
			i.disabled = false
			

func change_tax(tipe_of_tax, num):
	economy[tipe_of_tax] = num
	
	update()
