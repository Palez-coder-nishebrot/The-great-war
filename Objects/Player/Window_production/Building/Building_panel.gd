extends Control

onready var window = get_parent().get_parent().get_parent().get_parent().get_parent()

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
			$Label.text = building.good
			clear_resourses()
			show_resourses()
			
			if building.closed == false:
				$Button2.disabled = false
				$Button4.disabled = true
				update_information_of_factory()
			else:
				$VBoxContainer/Label.text = ""
				$VBoxContainer/Label2.text = "ЗАКРЫТО"
				$VBoxContainer/Label3.text = ""
				$Button2.disabled = true
				$Button3.disabled = true
				$Button4.disabled = false
		
		elif building.tipe == "process":
			update_information_of_procces()
		
		else:
			$Label.text = building.get_class()
			
		
	
func update_information_of_factory():
	
	if building.income >= 0: $VBoxContainer/Label3.text = "+" + str(building.income)
	else: $VBoxContainer/Label3.text = str(building.income)
	
	$Button2.text = "Субсидирование: " + subsidization_list[building.subsidization]
	$VBoxContainer/Label4.text = "Выпуск продукции:" + str(get_speed_production())
	$VBoxContainer/Label2.text= (
		"Рабочие:" + str(building.employed_number)+ "/" +str(building.max_employed_number))
	
	show_expansion_of_factory()
	

func show_expansion_of_factory():
	if building.expansion != null:
		$Button3.disabled = true
		$Button3.text = "Расширение(ост. " + str(building.expansion.max_time - building.expansion.time) + " дн.)"
	else:
		$Button3.disabled = false
		$Button3.text = "Расширить"
	

func get_speed_production():
	return building.employed_number * building.check_bonuses_for_production()
	
	
func show_resourses():
	var buttons = $HBoxContainer.get_children()
	for i in building.purchase:
		buttons[0].get_node("Label").text = str(building.purchase[i])
		buttons[0].icon = load(Players.sprites_of_goods[i])
		buttons[0].visible = true
		
		buttons.erase(buttons[0])


func clear_resourses():
	for i in $HBoxContainer.get_children():
		i.icon = load("res://Graphics/Sprites/Goods/kREST.png")
		i.get_node("Label").text = ""


func update_subsidization():
	building.subsidization = not building.subsidization


func update_information_of_procces():
	$Label.text = "Строительство"


func open_information():
	window.info_about_factory_window.factory = building
	window.info_about_factory_window.visible = true


func start_expansion_of_factory():
	building.start_expansion_of_factory()
	$Button3.disabled = true
	pass


func open_factory():
	building.open_factory()
	pass # Replace with function body.
