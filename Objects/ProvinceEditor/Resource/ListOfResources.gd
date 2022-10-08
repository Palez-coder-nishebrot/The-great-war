extends HBoxContainer

onready var parent = get_parent()

func append_resource_to_tile(good):
	var province = parent.province
	
	if province.resources.size() < 5:
		var list = parent.province_editor.list_of_resources_of_provinces
		list[province.name_of_tile][good] = 1
	parent.list_of_resources_in_region.update()
