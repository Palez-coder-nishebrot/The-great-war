extends Panel


func update_information(technology):
	visible = true
	$Label2.text = "Мы изучили " + technology.name_of_technology + ", что даем нам:"
	
	$Label3.text = get_effects_of_technology(technology)


func get_effects_of_technology(technology):
	var text = ""
	for i in technology.list_of_effects:
		text += i.get_effect()
		text += "\n"
	return text


func Close():
	visible = false
