extends Panel

signal update_province_panel(_list_)

var list_of_provinces: Dictionary = {}

@onready var info_about_factory_window = $Info_about_factory
@onready var player = get_parent().get_parent()
var empty_panel: Object
var list


func update_information():
	for i in Players.get_player_client().regions_list:
		if not list_of_provinces.has(i):
			spawn_panel(i)
	
	emit_signal("update_province_panel")
	
	info_about_factory_window.update_information()


func spawn_panels(list_):
	for i in list_:
		if not list_of_provinces.has(i):
			spawn_panel(i)


func spawn_panel(province):
	var panel = load("res://Objects/Player/Window_production/Province/ProvincePanel.tscn").instantiate()
	var _err = connect("update_province_panel", Callable(panel, "update_information"))
	panel.province = province
	panel.update_information()
	$ScrollContainer/VBoxContainer.add_child(panel)
	list_of_provinces[province] = panel


