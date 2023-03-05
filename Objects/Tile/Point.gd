extends TextureButton

class_name Region

const max_of_buildings: int = 8

var list_of_neighbors_tiles:    Array      = []
var list_of_buildings:          Array      = []
var list_of_units:              Array      = []
var list_of_households:         Array      = []
var goods_production_in_province: Array  = []

export(String) var name_of_tile = ""
var capital:             bool   = false
var player:              Object
var training_units:      Object

var resources:              Array  = []
var railways:               Object = Railways.new()
var infrastructure:         Object = Infrastructure.new()
var population_manager:     Object
var landscape:              Object = Landscape.new()
var population:             Object = Population.new()

onready var name_of_region_label: Object = $Label
var sprite_of_resource: Sprite


func _ready():
	var _err = ManagerDay.connect("allocate_workers_to_factories", self, "allocate_workers_to_factories")


func add_debug_nav_line(to):
	var line = Line2D.new()
	line.width = 3
	line.points = PoolVector2Array([(rect_global_position + rect_size / 2) + Vector2(-45, 0), to.rect_global_position + to.rect_size / 2])
	var g = Gradient.new()
	g.add_point(0, Color(0, 0.584314, 0.078431))
	g.add_point(1, Color(1, 1, 1))
	line.gradient = g
	
	get_parent().get_parent().add_child(line)


func add_debug_collider(polygon, global_pos):
	var collision = CollisionPolygon2D.new()
	collision.global_position = global_pos
	collision.polygon = polygon
	add_child(collision)


func start():
	set_mask()
	player.list_of_tiles.append(self)
	change_color_of_region(player.national_color)
	name_of_tile = name
	update_text_on_label()


func set_mask():
	var texture = texture_normal
	var data = texture.get_data()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(data)
	set_click_mask(bitmap)
	
	#$Sprite.texture = texture
	

func _pressed():
	Players.player.window_province.update_information(self)


func new_owner(new_owner):
	player.list_of_tiles.erase(self)
	for i in list_of_households:
		player.list_of_soc_classes.erase(i)
	
	player = new_owner
	player.list_of_tiles.append(self)
	
	for i in list_of_households:
		player.list_of_soc_classes.append(i)
	
	population_manager.player = player
	
	change_color_of_region(player.national_color)


func change_color_of_region(color):
	modulate = color


func build_building(name_of_building, cost):
	player.budget -= cost
	
	var factory_ex = player.economic_bonuses.find_factory(name_of_building)
	var factory = Factory.new()
	factory.name_of_factory = factory_ex.name_of_factory
	factory.good = factory_ex.good
	factory.purchase = factory_ex.purchase
	
	factory.closed = false
	factory.province = self
	factory.in_construction = true
	factory.start_build_factory()
	
	list_of_buildings.append(factory)


func update_text_on_label():
	if player == Players.player:
		name_of_region_label.text = name_of_tile + "(" + str(list_of_units.size()) + ")"
	else:
		name_of_region_label.text = name_of_tile + "(?)"
	

func choose_units():
	if Players.player.get_groups().has("Human"):
		Players.player.list_of_active_units.clear()
		Players.player.list_of_active_units.append_array(list_of_units)
		Players.player.window_list_of_units.show_units()


func set_default_region():
	change_color_of_region(player.national_color)
	name_of_region_label.text = name_of_tile


func show_resources():
	var good = Players.player.information.showing_good
	#breakpoint
	if resources.has(good):
		change_color_of_region(Color(0.321569, 0.670588, 0.184314))
	else:
		change_color_of_region(Color(0.350586, 0.350586, 0.350586))


func show_name_of_region_label():
	name_of_region_label.text = name_of_tile


func show_units():
	if list_of_units.size() == 0:
		name_of_region_label.text = "Пусто"
	else:
		name_of_region_label.text = "Дивизии(" + str(list_of_units.size()) + ")"


func get_production_bonuses():
	var factory_production = (railways.level * 0.1)
	var DP_production      = (railways.level * 0.05)
	
	return [
		factory_production,
		DP_production,
	]


func get_goods_in_province():
	goods_production_in_province.clear()
	for i in list_of_buildings:
		if i.in_construction == false and i.closed == false:
			goods_production_in_province.append(i.good)
	
	var res = resources.duplicate()
	goods_production_in_province.append_array(res)


func get_factories_in_province():
	var list = []
	for i in list_of_buildings:
		list.append(i.name_of_factory)
	return list

func get_open_factories_in_province():
	var list = []
	for i in list_of_buildings:
		if i.closed == false:
			list.append(i)
	return list

func allocate_workers_to_factories():
	var quantity_of_open_factories = get_open_factories_in_province().size()
	var workers_units = population.population_types[1]
	var workers = workers_units.quantity
	
	if quantity_of_open_factories != 0 and population.population_types[1].quantity > 0:
		workers_units.unemployed_quantity = 0
		var reserve_of_workers = 0.0 
		
		var r =  stepify(workers / quantity_of_open_factories, 0.01)
		var reserve = 0
		var list = check_factories()
		for factory in list:
			factory.workers_quantity = r + reserve
			
			if factory.workers_quantity > factory.max_employed_number:
				reserve += factory.workers_quantity - factory.max_employed_number
				factory.workers_quantity = factory.max_employed_number
			
			workers -= factory.workers_quantity
		workers_units.unemployed_quantity = workers + reserve_of_workers
	
	else:
		workers_units.unemployed_quantity = workers


func check_factories():
	var list = []
	for i in list_of_buildings:
		if i.closed == false:
			list.append(i)
	return list
