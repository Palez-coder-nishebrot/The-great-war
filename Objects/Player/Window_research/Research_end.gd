extends Panel


func update_information(dict, name_technology):
	visible = true
	$Label2.text = "Мы изучили " + name_technology + ", что даем нам:"
	
	$Label3.text = Research.return_results_of_research(dict)


func Close():
	visible = false
