extends Panel

signal update_region_panel

var accounted_regions_list: Array = []

@onready var region_panel_example = $region_panel
@onready var container           = $ScrollContainer/VBoxContainer


func update_information():
	var list = Players.player.regions_list

	emit_signal("update_region_panel")
	
	spawn_panels(list)
	
	#$HouseholdPanel.update_information()


func spawn_panels(list):
	for region in list:
		if not accounted_regions_list.has(region):
			spawn_panel(region)


func spawn_panel(region):
	var panel = region_panel_example.duplicate()
	
	panel.region = region
	accounted_regions_list.append(region)
	connect("update_region_panel", Callable(panel, "update"))
	
	container.add_child(panel)
	panel.update()
