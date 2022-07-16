extends Panel

signal update_province_panel(_list_)

var list_of_panels: Array = []

onready var info_about_factory_window = $Info_about_factory
var empty_panel: Object
var list


func spawn_empty_panel():
	if list.size() > 4:
		var province = load("res://Objects/Player/Window_production/Province/Province_panel.tscn").instance()
		$ScrollContainer/VBoxContainer.add_child(province)
		province.get_node("HBoxContainer").add_child(load("res://Objects/Player/Window_production/Building/Building_panel.tscn").instance())
		empty_panel = province

func update_information():
	list = update_list()
	emit_signal("update_province_panel", list, self)
	
	spawn_panels(list)
	info_about_factory_window.update_information()

	if empty_panel != null:
		empty_panel.queue_free()
	spawn_empty_panel()


func update_list():
	var list_of_provinces: Array = []
	for i in Players.player.list_of_tiles:
		if i.list_of_buildings.size() != 0:
			list_of_provinces.append(i)
	return list_of_provinces


func spawn_panels(list):
	for i in list:
		if not list_of_panels.has(i):
			spawn_panel(i)


func spawn_panel(tile):
	var province = load("res://Objects/Player/Window_production/Province/Province_panel.tscn").instance()
	connect("update_province_panel", province, "update_information")
	province.province = tile
	province.update()
	$ScrollContainer/VBoxContainer.add_child(province)
	list_of_panels.append(tile)
	
