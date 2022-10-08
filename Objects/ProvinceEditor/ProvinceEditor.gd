extends Node2D

const speed_of_camera: int            = 50
const speed_of_zoom:   float          = 0.1
const MAX_zoom:        float          = 2.5
const MIN_zoom:        float          = 1.0

onready var window_province:      Panel = $CanvasLayer/Province
var list_of_path_of_provinces              = {}
var list_of_resources_of_provinces         = {}
var list_of_factories_of_provinces         = {}
var list_of_household_of_provinces         = {}
var list_of_landscape_of_provinces         = {}
var list_of_villages_of_provinces          = {}

var list_of_tiles

const information = {showing_map = false}

func _ready():
	Players.player = self
	load_list()


func _process(delta):
	
	if Input.is_action_pressed("W"):# and position.y >= 1200:
		position.y -= speed_of_camera

	if Input.is_action_pressed("A"):# and position.x >= 1600:
		position.x -= speed_of_camera
		
	if Input.is_action_pressed("S"):# and position.y <= 2100:
		position.y += speed_of_camera
		
	if Input.is_action_pressed("D"):# and position.x <= 2400:
		position.x += speed_of_camera
		
		
func _input(event):
	if event.is_pressed() and not event is InputEventKey:
		if event.button_index == BUTTON_WHEEL_UP:
			if $Camera2D.zoom.x >= MIN_zoom:
				$Camera2D.zoom -= Vector2(speed_of_zoom, speed_of_zoom)
		elif event.button_index == BUTTON_WHEEL_DOWN:
			if $Camera2D.zoom.x <= MAX_zoom:
				$Camera2D.zoom += Vector2(speed_of_zoom, speed_of_zoom)


func load_list():
	var file = ResourceLoader.load("res://Objects/Provinces/Paths_of_provinces.tres")
	list_of_path_of_provinces      = file.list_of_path_of_provinces.duplicate()
	list_of_resources_of_provinces = file.list_of_resources_of_provinces.duplicate()
	list_of_factories_of_provinces = file.list_of_factories_of_provinces.duplicate()
	list_of_household_of_provinces = file.list_of_household_of_provinces.duplicate()
	list_of_landscape_of_provinces = file.list_of_landscape_of_provinces.duplicate()
	list_of_villages_of_provinces  = file.list_of_villages_of_provinces.duplicate()
	
	get_parent().get_node("TileMap").append_tiles_in_list()
	get_parent().get_node("TileMap").set_collision_of_provinces()
	
	list_of_tiles = get_parent().get_node("TileMap").list_of_tiles
	
	for i in get_parent().get_node("TileMap").list_of_tiles:
		var tile = list_of_tiles[i]
#		if list_of_path_of_provinces.has(i):
#			for y in list_of_path_of_provinces[i]:
#				tile.list_of_neighbors_tiles.append(list_of_tiles[y])
		
		append_resources(tile)
		
		append_factories(tile)
		
		if list_of_household_of_provinces.has(i):
			for household in list_of_household_of_provinces[i]:
				tile.list_of_households.append(household)
		
#		if list_of_landscape_of_provinces.has(i):
#			tile.landscape = list_of_landscape_of_provinces[i]
	
	
func append_resources(tile):
	if not list_of_resources_of_provinces.has(tile.name_of_tile):
		list_of_resources_of_provinces[tile.name_of_tile] = {}
	tile.resources = list_of_resources_of_provinces[tile.name_of_tile]


func append_factories(tile):
	if not tile.get_groups().has("Village"):
		if not list_of_factories_of_provinces.has(tile.name_of_tile):
			list_of_factories_of_provinces[tile.name_of_tile] = []
		tile.list_of_buildings = list_of_factories_of_provinces[tile.name_of_tile]


func save_changes():
	var file = Prov_saver.new()
	
	file.list_of_resources_of_provinces = list_of_resources_of_provinces
	file.list_of_path_of_provinces = list_of_path_of_provinces
	file.list_of_factories_of_provinces = list_of_factories_of_provinces
	file.list_of_household_of_provinces = list_of_household_of_provinces
	file.list_of_landscape_of_provinces = list_of_landscape_of_provinces
	file.list_of_villages_of_provinces = list_of_villages_of_provinces
	ResourceSaver.save("res://Objects/Provinces/Paths_of_provinces.tres", file)
