extends HBoxContainer

onready var parent = get_parent()

func update():
	var region = parent.province
	var resources = region.resources.keys()
	for i in get_children():
		if not resources.empty():
			var good = resources[0]
			i.good = good
			i.icon = load(Players.sprites_of_goods[good])
			resources.erase(good)
		else:
			i.good = null
			i.icon = load("res://Graphics/Sprites/Goods/kREST.png")


func erase_resource(good):
	parent.province.resources.erase(good)
	parent.province_editor.list_of_resources_of_provinces[parent.province.name_of_tile].erase(good)
	update()
