extends VBoxContainer

signal update_info_about_factory

var list_of_factories: Dictionary = {}
var province

onready var name_of_tile = $Label

func update_information():
	$Label.text = province.name_of_tile
	for i in province.list_of_buildings:
		if not list_of_factories.has(i):
			spawn_panel(i)
	
	emit_signal("update_info_about_factory")
	
	if list_of_factories.size() == 0:
		visible = false
	else:
		visible = true


func spawn_panel(factory):
	var panel = load("res://Objects/Player/Window_production/Factory/FactoryPanel.tscn").instance()
	panel.province = province
	panel.factory = factory
	var _err = connect("update_info_about_factory", panel, "update_information")
	list_of_factories[factory] = panel
	panel.update_information()
	panel.show_purchase()
	add_child(panel)
