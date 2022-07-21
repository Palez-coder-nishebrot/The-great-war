extends Panel

var setting_path: bool = false
var setting_res:  bool = false
var province
onready var province_editor = get_parent().get_parent()


func update_information(province_, tipe):
	hide()
	return_color_of_provinces()
	visible = true
	province = province_
	$VBoxContainer/Label.text = province.name_of_tile
	$VBoxContainer/Button4.text = province.landscape
	
	$Panel.update_information()
		

func hide():
	$ScrollContainer.visible = false
	$HBoxContainer.visible = false
	$HBoxContainer2.visible = false
	$HBoxContainer3.visible = false
	$FactoryGoods.visible = false


func set_path(prov):
	if setting_path == true:
		var name_of_prov = prov.name_of_tile
		var list = province_editor.list_of_path_of_provinces
		if province != null and not province.list_of_neighbors_tiles.has(prov):
			
			append_tile_to_path(list, prov, province)
			append_tile_to_path(list, province, prov)
			
			show_paths_of_province()


func append_tile_to_path(list, new_prov, old_prov):
	var name_of_new_prov = new_prov.name_of_tile
	if list.has(old_prov.name_of_tile):
		list[old_prov.name_of_tile].append(name_of_new_prov)
				
	else:
		list[old_prov.name_of_tile] = [name_of_new_prov]
	
	old_prov.list_of_neighbors_tiles.append(new_prov)


func clear_cont():
	set_color_of_province(province, Color.white)
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i !=  $ScrollContainer/VBoxContainer/Button:
			set_color_of_province(i.province, Color.white)
			i.queue_free()

func return_color_of_provinces():
	if province != null:
		set_color_of_province(province, Color.white)
		for i in province.list_of_neighbors_tiles:
			set_color_of_province(i, Color.white)


func show_paths_of_province():
	clear_cont()
	set_color_of_province(province, Color.red)
	
	for i in province.list_of_neighbors_tiles:
		var button = $ScrollContainer/VBoxContainer/Button.duplicate()
		button.text = i.name_of_tile
		button.province = i
		button.visible = true
		set_color_of_province(i, Color.greenyellow)
		$ScrollContainer/VBoxContainer.add_child(button)


func set_color_of_province(prov, color):
	prov.get_node("Sprite").modulate = color


func erase_province(province_):
	var list = province_editor.list.paths_of_provinces
	
	list[province.name_of_tile].erase(province_.name_of_tile)
	list[province_.name_of_tile].erase(province.name_of_tile)
	
	province.list_of_neighbors_tiles.erase(province_)
	province_.list_of_neighbors_tiles.erase(province)
	
	show_paths_of_province()


func erase_resource(good):
	province.resources.erase(good)
	province_editor.list_of_resources_of_provinces[province.name_of_tile].erase(good)
	show_resources_of_tile()
	

func erase_factory(good):
	province.list_of_buildings.erase(good)
	province_editor.list_of_factories_of_provinces[province.name_of_tile].erase(good)
	show_factories_of_tile()


func start_setting_path():
	hide()
	$ScrollContainer.visible = true
	setting_path = not setting_path
	if setting_path == true:
		Input.set_custom_mouse_cursor(load("res://Graphics/Sprites/Tile/mouse.png"))
	else:
		Input.set_custom_mouse_cursor(null)
	show_paths_of_province()


func start_setting_resources():
	setting_path = false
	setting_res = not setting_res
	
	hide()
	
	$HBoxContainer.visible = true
	$HBoxContainer2.visible = true
	
	clear_cont()
	show_resources_of_tile()


func start_setting_factories():
	if not province.get_groups().has("Village"):
		hide()
		$HBoxContainer3.visible = true
		$FactoryGoods.visible = true
		show_factories_of_tile()


func append_resource_to_tile(good):
	if province.resources.size() < 5:
		var list = province_editor.list_of_resources_of_provinces
		
		if list.has(province.name_of_tile):
			list[province.name_of_tile][good] = 1
		
		else:
			list[province.name_of_tile] = {good: 1}
		
		province.resources[good] = 1
		show_resources_of_tile()


func append_factory_to_tile(good):
	if province.list_of_buildings.size() < 5:
		
		var list = province_editor.list_of_factories_of_provinces
		province.list_of_buildings.append(good)
		
		if list.has(province.name_of_tile):
			list[province.name_of_tile].append(good)
		
		else:
			list[province.name_of_tile] = [good]
	show_factories_of_tile()


func show_factories_of_tile():
	var factories = province.list_of_buildings.duplicate()
	for i in $HBoxContainer3.get_children():
		if not factories.empty():
			var good = factories[0]
			i.icon = load(Players.sprites_of_goods[good])
			factories.erase(good)
		else:
			i.icon = load("res://Graphics/Sprites/Goods/kREST.png")
			
			
func show_resources_of_tile():
	var resources = province.resources.keys()
	for i in $HBoxContainer2.get_children():
		if not resources.empty():
			var good = resources[0]
			i.good = good
			i.icon = load(Players.sprites_of_goods[good])
			resources.erase(good)
		else:
			i.good = null
			i.icon = load("res://Graphics/Sprites/Goods/kREST.png")
