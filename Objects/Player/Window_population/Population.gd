extends Panel

signal update_household_panels()

var list_of_soc_classes: Array = []


func update_information():
#	var list = Players.player.list_of_soc_classes
#
#	emit_signal("update_household_panels")
#	spawn_panels(list)
	pass


func spawn_panels(list):
	for i in list:
		if not list_of_soc_classes.has(i):
			spawn_panel(i)


func spawn_panel(soc_class):
	var panel = load("res://Objects/Player/Window_population/Household_button/Household.tscn").instance()
	connect("update_household_panels", panel, "update_information")
	panel.province = soc_class.province
	panel.household = soc_class
	panel.update()
	$ScrollContainer/VBoxContainer.add_child(panel)
	list_of_soc_classes.append(soc_class)
