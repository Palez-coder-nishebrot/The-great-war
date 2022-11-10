extends Button


export(String) var soc_class = ""
export(String) var array = ""

func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		var region = get_parent().get_parent().region
		if event.get_button_index() == BUTTON_RIGHT:
			if region.get(array) != 0:
				plus(region, -1)
		else:
			plus(region, 1)
		update()


func update():
	var region = get_parent().get_parent().region
	text = "Добавить класс " + soc_class + "(" + str(region.get(array)) + ")"


func plus(region, num):
	var par = get_parent().get_parent().parent.get_parent().provinces[region.name_of_region]
	if soc_class == "Worker":
		region.quantity_of_workers += num
		par.workers += num
		
	else:
		region.quantity_of_factory_workers += num
		par.factory_workers += num
