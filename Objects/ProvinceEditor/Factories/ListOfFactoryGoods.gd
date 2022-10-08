extends HBoxContainer

onready var parent = get_parent()

func append_factory_to_tile(good):
	var province = parent.province
	if province.list_of_buildings.size() < 5 and not province.list_of_buildings.has(good):
		
		var list = parent.province_editor.list_of_factories_of_provinces
		
		list[province.name_of_tile].append(good)
	parent.list_of_factories_in_region.update()
