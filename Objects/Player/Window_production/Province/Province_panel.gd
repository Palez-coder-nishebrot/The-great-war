extends Control

signal update_info(list)

var province
var list_of_panels: Array = []


func update_information(list, parent):
	if not list.has(province):
		parent.list_of_panels.erase(province)
		queue_free()
	else:
		update()

func update():
	$Label.text = province.name_of_tile + "(" + str(province.household.quanity) + ")"
	emit_signal("update_info", list_of_panels)

	for i in province.list_of_buildings:
		if not list_of_panels.has(i):
			var panel = load("res://Objects/Player/Window_production/Building/Building_panel.tscn").instance()
			
			panel.building = i
			list_of_panels.append(i)
			panel.update_information(list_of_panels)
			connect("update_info", panel, "update_information")
			
			$HBoxContainer.add_child(panel)
			pass
