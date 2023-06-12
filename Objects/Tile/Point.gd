extends TextureButton

class_name Region

const max_of_buildings: int = 8

@export var dp_goods      = [] # (Array, Resource)
@export var factory_goods = [] # (Array, Resource)
@export var labourer_quantity: int = 12
@export var worker_quantity: int   = 0

var list_of_neighbors_tiles:    Array    = []
var DP_list:                    Array    = []
var list_of_buildings:          Array    = []
var list_of_units:              Array    = []
var goods_production_in_province: Array  = []

@export var name_of_tile: String = ""
var capital:             bool   = false
var player:              Object
var training_units:      Object

var railways:               Object = Railways.new()
var infrastructure:         Object = Infrastructure.new()
var population_manager:     Object
var landscape:              Object = Landscape.new()
var population:             Object = Population.new()

@onready var name_of_region_label: Object = $Label
var sprite_of_resource: Sprite2D


func _ready():
	var _err = ManagerDay.connect("allocate_workers_to_factories", Callable(self, "allocate_workers_to_factories"))
	_err     = ManagerDay.connect("allocate_workers_to_DP", Callable(self, "allocate_workers_to_DP"))


func add_debug_nav_line(to):
	var line = Line2D.new()
	line.width = 3
	line.points = PackedVector2Array([(global_position + size / 2) + Vector2(-45, 0), to.global_position + to.size / 2])
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


func start(): # Вызывается, при стартовой настройке регионов
	set_mask()
	name_of_tile = name
	update_text_on_label()


func set_mask():
	var texture = texture_normal
	var image = texture.get_image()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)
	set_click_mask(bitmap)


func _pressed():
	Players.player.window_province.update_information(self)


func set_new_owner(new_owner):
	if player != null:
		player.erase_region(self)
		register_enterprises(new_owner, player)
	else:
		register_enterprises(new_owner)
	
	player = new_owner
	player.register_region(self)
	set_enterprises_efficiency(new_owner.economy_manager)
	change_color_of_region(new_owner.national_color)


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
	name_of_region_label.position = Vector2(size.x / 2, size.y / 2)
	name_of_region_label.set_horizontal_alignment(0)
	name_of_region_label.set_vertical_alignment(0)
	if player == Players.player:
		name_of_region_label.text = name_of_tile + "(" + str(list_of_units.size()) + ")"
	else:
		name_of_region_label.text = name_of_tile + "(?)"


func set_default_region():
	change_color_of_region(player.national_color)
	name_of_region_label.text = name_of_tile


func show_resources():
	var good = Players.player.information.showing_good
	#breakpoint
	if get_resources().has(good):
		change_color_of_region(Color(0.321569, 0.670588, 0.184314))
	else:
		change_color_of_region(Color(0.350586, 0.350586, 0.350586))


func show_name_of_region_label():
	name_of_region_label.text = name_of_tile


func get_production_bonuses_from_railways():
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
	
		goods_production_in_province.append_array(get_resources())


func get_resources():
	var list = []
	for i in DP_list:
		list.append(i.good)
	return list


func get_open_factories_in_province():
	var list = []
	for i in list_of_buildings:
		if i.closed == false:
			list.append(i)
	return list


func allocate_workers_to_factories():
	var open_factories_in_province = get_open_factories_in_province()
	var quantity_of_open_factories = open_factories_in_province.size()
	var workers_units = population.population_types[1]
	var workers = workers_units.quantity
	
	if quantity_of_open_factories != 0 and population.population_types[1].quantity > 0:
		workers_units.unemployed_quantity = 0
		var reserve_of_workers = 0.0 
		
		var r =  snapped(workers / quantity_of_open_factories, 0.01)
		var reserve = 0
		
		for factory in open_factories_in_province:
			factory.workers_quantity = r + reserve
			
			if factory.workers_quantity > factory.max_employed_number:
				reserve += factory.workers_quantity - factory.max_employed_number
				factory.workers_quantity = factory.max_employed_number
			
			workers -= factory.workers_quantity
		workers_units.unemployed_quantity = workers + reserve_of_workers
	
	else:
		workers_units.unemployed_quantity = workers
	


func allocate_workers_to_DP():
	var workers_unit = population.population_types[0]
	for dp in DP_list:
		dp.workers_unit = workers_unit
		dp.workers_quantity = workers_unit.quantity


func get_factories_list():
	return list_of_buildings


func set_enterprises_efficiency(economy_manager):
	var bonuses_from_railways = get_production_bonuses_from_railways()
	for i in DP_list:
		i.production_efficiency      = economy_manager.get_DP_efficiency_production() + bonuses_from_railways[1]
		i.good_production_efficiency = economy_manager.get_good_production_efficiency(i.good)
	
	for i in get_factories_list():
		i.production_efficiency      = economy_manager.get_factories_efficiency_production() + bonuses_from_railways[0]
		i.good_production_efficiency = economy_manager.get_good_production_efficiency(i.good)
		i.type_production_efficiency = economy_manager.get_factory_types_efficiency_production(i.type_factory)
		i.economy_manager            = economy_manager

func register_enterprises(new_player, old_player = null):
	var new_player_manager = new_player.economy_manager
	
	if old_player != null:
		var old_player_manager = old_player.economy_manager
		for i in DP_list:
			old_player_manager.DP_list.erase(i)
		for i in get_factories_list():
			old_player_manager.factories_list.erase(i)
	
	for i in DP_list + get_factories_list():
		i.economy_manager = new_player_manager
	
	new_player_manager.factories_list.append_array(get_factories_list())
	new_player_manager.DP_list.append_array(DP_list)
