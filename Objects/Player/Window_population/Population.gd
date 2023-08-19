extends Panel

signal update_region_panel(population_units_list)

var accounted_pop_units_list: Array = []

@onready var pop_unit_panel_example = $pop_unit_panel
@onready var container              = $ScrollContainer/VBoxContainer


func update_information():
	var list = Players.get_player_client().population_units_list

	emit_signal("update_region_panel", list)
	
	spawn_panels(list)
	
	#$HouseholdPanel.update_information()


func spawn_panels(list):
	for pop_unit in list:
		if not accounted_pop_units_list.has(pop_unit):
			spawn_panel(pop_unit, list)


func spawn_panel(pop_unit, list):
	var panel = pop_unit_panel_example.duplicate()
	
	panel.pop_unit = pop_unit
	accounted_pop_units_list.append(pop_unit)
	connect("update_region_panel", Callable(panel, "update"))
	
	container.add_child(panel)
	panel.update(list)
