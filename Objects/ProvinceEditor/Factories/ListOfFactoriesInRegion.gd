extends HBoxContainer

onready var parent = get_parent()

func update():
	var factories = parent.province.list_of_buildings.duplicate()
	var buttons = get_children()
	
	for i in factories:
		if buttons.size() != 0:
			buttons[0].icon = load(Players.sprites_of_goods[i])
			buttons[0].good = i
			buttons.remove(0)
	
	for i in buttons:
		i.icon = load("res://Graphics/Sprites/Goods/kREST.png")


func erase_factory(good):
	var province = parent.province
	province.list_of_buildings.erase(good)
	parent.province_editor.list_of_factories_of_provinces[province.name_of_tile].erase(good)
	update()
