extends Panel

signal update_household_panels()

var list_of_soc_classes: Array = []


func _ready():
	spawn_panel(Players.player.capitalists_manager, "Промышленники")


func update_information():
	var list = Players.player.list_of_tiles

	emit_signal("update_household_panels")
	
	spawn_panels(list)
	
	$HouseholdPanel.update_information()


func spawn_panels(list):
	for i in list:
		if not list_of_soc_classes.has(i.population_manager):
			spawn_panel(i.population_manager, "Домохозяйство")


func spawn_panel(soc_class, tipe_of_soc_class):
	var panel = load("res://Objects/Player/Window_population/Household_button/Household.tscn").instance()
	connect("update_household_panels", panel, "update_information")
	panel.province = soc_class.province
	panel.household = soc_class
	panel.tipe_of_soc_class = tipe_of_soc_class
	panel.update()
	$ScrollContainer/VBoxContainer.add_child(panel)
	list_of_soc_classes.append(soc_class)
