extends Panel

var setting_path: bool = false
var setting_res:  bool = false
var setting_villages: bool = false
var province
onready var province_editor = get_parent().get_parent()

onready var list_of_factory_goods       = $ListOfFactoryGoods
onready var list_of_resources           = $ListOfResources
onready var list_of_resources_in_region = $ResourcesInRegion
onready var list_of_factories_in_region = $FactoriesInRegion
onready var households                  = $Households

onready var path_button                 = $Paths/PathButton
onready var list_of_path                = $Paths

onready var buttons                     = $Buttons
onready var buttons_label               = $Buttons/Label
onready var set_path_button             = $Buttons/Button
onready var set_relief_button           = $Buttons/Button2


func update_information(province_, tipe):
	hide()
	return_color_of_provinces()
	visible = true
	province = province_
	buttons_label.text = province.name_of_tile
	set_relief_button.text = province.landscape
	
	setting_path     = false
	setting_res      = false
	setting_villages = false
	
	households.update_information()
	list_of_resources_in_region.update()
	list_of_factories_in_region.update()


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
	for i in list_of_path.get_children():
		if i !=  path_button:
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
		var button = path_button.duplicate()
		button.text = i.name_of_tile
		button.province = i
		button.visible = true
		set_color_of_province(i, Color.greenyellow)
		list_of_path.add_child(button)


func set_color_of_province(prov, color):
	prov.modulate = color


func erase_province(province_):
	var list = province_editor.list.paths_of_provinces
	
	list[province.name_of_tile].erase(province_.name_of_tile)
	list[province_.name_of_tile].erase(province.name_of_tile)
	
	province.list_of_neighbors_tiles.erase(province_)
	province_.list_of_neighbors_tiles.erase(province)
	
	show_paths_of_province()
	

#func erase_factory(good):
#	province.list_of_buildings.erase(good)
#	province_editor.list_of_factories_of_provinces[province.name_of_tile].erase(good)
#	show_factories_of_tile()


func start_setting_path():
	hide()
	$ScrollContainer.visible = true
	setting_path = not setting_path
	if setting_path == true:
		Input.set_custom_mouse_cursor(load("res://Graphics/Sprites/Tile/mouse.png"))
	else:
		Input.set_custom_mouse_cursor(null)
	show_paths_of_province()

#
#func start_setting_resources():
#	hide()
#
#	setting_path = false
#	setting_res = not setting_res
#
#	list_of_resources.visible = true
#	list_of_resources_in_region.visible = true
#
#	clear_cont()
#	show_resources_of_tile()


#func start_setting_factories():
#	hide()
#	$HBoxContainer3.visible = true
#	list_of_factory_goods.visible = true
#	show_factories_of_tile()
#
#
#func append_factory_to_tile(good):
#	if province.list_of_buildings.size() < 5 and not province.list_of_buildings.has(good):
#
#		var list = province_editor.list_of_factories_of_provinces
#
#		list[province.name_of_tile].append(good)
#
#	show_factories_of_tile()


#func show_factories_of_tile():
#	var factories = province.list_of_buildings
#	var buttons = $HBoxContainer3.get_children()
#	var token = 0
#
#	for i in factories:
#		buttons[token].icon = load(Players.sprites_of_goods[i])
#		buttons[token].good = i
#		buttons.erase(buttons[token])
#	for i in buttons:
#		i.icon = load("res://Graphics/Sprites/Goods/kREST.png")
	
			
#func show_resources_of_tile():
#	var resources = province.resources.keys()
#	for i in list_of_resources_in_region.get_children():
#		if not resources.empty():
#			var good = resources[0]
#			i.good = good
#			i.icon = load(Players.sprites_of_goods[good])
#			resources.erase(good)
#		else:
#			i.good = null
#			i.icon = load("res://Graphics/Sprites/Goods/kREST.png")

