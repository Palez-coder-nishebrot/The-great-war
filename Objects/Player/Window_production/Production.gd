extends Panel

signal update_province_panel(_list_)

var list_of_provinces: Dictionary = {}

onready var info_about_factory_window = $Info_about_factory
onready var player = get_parent().get_parent()
var empty_panel: Object
var list


#func spawn_empty_panel():
#	if empty_panel != null:
#		empty_panel.queue_free()
#	if list.size() >= 4:
#		var province = load("res://Objects/Player/Window_production/Province/Province_panel.tscn").instance()
#		$ScrollContainer/VBoxContainer.add_child(province)
#		province.get_node("HBoxContainer").add_child(load("res://Objects/Player/Window_production/Building/Building_panel.tscn").instance())
#		empty_panel = province


func update_information():
	for i in Players.player.list_of_tiles:
		if not list_of_provinces.has(i):
			spawn_panel(i)
	
	emit_signal("update_province_panel")
	
	info_about_factory_window.update_information()


func spawn_panels(list):
	for i in list:
		if not list_of_provinces.has(i):
			spawn_panel(i)


func spawn_panel(province):
	var panel = load("res://Objects/Player/Window_production/Province/ProvincePanel.tscn").instance()
	connect("update_province_panel", panel, "update_information")
	panel.province = province
	panel.update_information()
	$ScrollContainer/VBoxContainer.add_child(panel)
	list_of_provinces[province] = panel


