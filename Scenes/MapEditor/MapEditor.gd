extends Node2D

var list_of_regions: Dictionary = {}

var provinces: Dictionary = {}

func _ready():
	TranslationServer.set_locale("en")
	set_dict_of_regions()
	create_map()
	#set_d()
	set_color_of_regions()
	set_collisions_of_regions()


#func set_d():
#	var list = []
#	for i in get_children():
#		if i.name != "Map" and i.name != "ClientEditor":
#			var province = {
#				"name_of_province": i.name_of_region,
#				"resources": [],
#				"factories": [],
#				"households": [],
#				}
#			#breakpoint
#			list.append(province)
#	var file = SavedRegions.new()
#	file.regions = list
#	ResourceSaver.save("res://Objects/Provinces/SavedRegions.tres", file)


func create_map():
	var map = load("res://Scenes/TileMap/TileMap.tscn").instance()
	get_node("Map").position = map.get_node("Map").position
	
	var children = get_children()
	var map_children = map.get_children()
	
	for i in map_children:
		if i.name != "Map":
			create_region(i)


func set_dict_of_regions():
	var file = ResourceLoader.load("res://Objects/Provinces/SavedRegions.tres")
	
	for i in file.regions:
		provinces[i.name_of_province] = i
		#i["railways"] = 0
	#breakpoint


func create_region(region_from_tilemap):
	var region = load("res://Scenes/MapEditor/EditorTile/EditorTile.tscn").instance()
	add_child(region)
	region.texture = region_from_tilemap.texture
	region.name_of_region = region_from_tilemap.name
	region.label.text = region_from_tilemap.name
	region.position = region_from_tilemap.position
	
	if not provinces.has(region.name_of_region):
		provinces[region.name_of_region] = {
				"name_of_province": region.name_of_region,
				"resources": [],
				"factories": [],
				#"households": [],
				"factory_workers": 0,
				"workers": 0,
				#"clerks": 0,
				"railways": 0,
				}
	region.railways = provinces[region.name_of_region].railways
	region.resources = provinces[region.name_of_region].resources
	region.list_of_buildings = provinces[region.name_of_region].factories
	region.quantity_of_factory_workers = provinces[region.name_of_region].factory_workers
	region.quantity_of_workers = provinces[region.name_of_region].workers
	#region.list_of_households = provinces[region.name_of_region].households
	
#	for i in 3:
#		region.list_of_households.append(SavedHousehold.new())
	
	list_of_regions[region.name_of_region] = region
	

func set_color_of_regions():
	var folder: Directory = Directory.new()
	folder.open("res://Resources/StatesOnStartGame/States/")
	folder.list_dir_begin(true, true)
	
	var folder_name = folder.get_next()
	
	while folder_name != "":
		var file = load("res://Resources/StatesOnStartGame/States/" + folder_name)
		
		for i in file.list_of_regions:
			list_of_regions[i].modulate = file.national_color
		
		folder_name = folder.get_next()


func set_collisions_of_regions():
	var file = ResourceLoader.load("res://Objects/Provinces/CollisionPolygons_of_provinces.tres")
	
	for i in file.list_of_pol_of_provinces:
		var region = list_of_regions[i]
		region.collision.polygon = file.list_of_pol_of_provinces[i]
	
		region.collision.position.x -= region.get_rect().size.x / 2
		region.collision.position.y -= region.get_rect().size.y / 2
