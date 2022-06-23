extends Control

const subsidization_list: Dictionary = {
	true: "ДА",
	false: "НЕТ",
}

var building

func update_information(list):
	if not is_instance_valid(building):
		list.erase(building)
		queue_free()
	else:
		if building.tipe == "factory":
			update_information_of_factory()
		elif building.tipe == "process":
			update_information_of_procces()
		else:
			$Label.text = building.get_class()
			

func update_information_of_factory():
	if building.closed == false:
		$VBoxContainer/Label.text = building.good
		$VBoxContainer/Label5.text = "+" + str(building.income) #str(building.money)
		$VBoxContainer/Label6.text = "Субсидирование: " + subsidization_list[building.subsidization]
		$VBoxContainer/Label2.text= (
			"Рабочие:" + str(building.employed_number)+ "/" +str(building.max_employed_number))
		show_resourses()
	else:
		$VBoxContainer/Label4.text = "\n \n \n \n"
		$VBoxContainer/Label3.text = ""
		$VBoxContainer/Label2.text = "ЗАКРЫТО"
		$VBoxContainer/Label5.text = ""
		$VBoxContainer/Label6.disabled = true
	
	
func show_resourses():
	$VBoxContainer/Label4.text = ""
	for i in building.purchase:
		$VBoxContainer/Label4.text += i + ": " + str(building.purchase[i]) + "\n"


func update_subsidization():
	building.subsidization = not building.subsidization
	$VBoxContainer/Label6.text = "Субсидирование: " + subsidization_list[building.subsidization]


func update_information_of_procces():
	$VBoxContainer/Label.text = "строительство"

