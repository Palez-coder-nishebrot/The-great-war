@tool
extends TextureButton

class_name Region

const max_of_buildings: int = 8

@export var dp_goods:      Array[Good] = [] # (Array, Resource)
@export var factory_goods: Array[FactoryTipe] = [] # (Array, Resource)
@export var labourer_quantity: int = 12
@export var worker_quantity: int   = 0

var list_of_neighbors_tiles:    Array[Region]              = []
var projects_list:              Array[ConstructionProject] = []
var DP_list:                    Array[DP]                  = []
var list_of_buildings:          Array[Factory]             = []
var list_of_units:              Array                      = []
var produced_goods:             Array[Good]                = []

@export var name_of_tile: String = ""
var capital:             bool   = false
var player:              Object
var training_units:      Object

var railways:               Object = Railways.new()
var infrastructure:         Object = Infrastructure.new()
var landscape:              Object = Landscape.new()
var population:             Object = Population.new()

@onready var name_of_region_label: Object = $Label
var sprite_of_resource: Sprite2D


func _ready():
	var _err = ManagerDay.connect("allocate_workers_to_factories", Callable(self, "allocate_workers_to_factories"))
	_err     = ManagerDay.connect("allocate_workers_to_DP", Callable(self, "allocate_workers_to_DP"))
	name_of_region_label.position = Vector2(size.x / 2, size.y / 2)
	name_of_region_label.set_horizontal_alignment(0)
	name_of_region_label.set_vertical_alignment(0)
	name_of_region_label.text = name


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
	spawn_enterprises()
	set_enterprises_efficiency(player.economy_manager)
	

func spawn_enterprises():
	for good in dp_goods:
		var dp = DP.new(good, player.economy_manager)
		var _err
		DP_list.append(dp)
		player.economy_manager.DP_list.append(dp)
		append_produced_good(good)
		
		_err = dp.connect("append_produced_good", Callable(self, "append_produced_good"))
		_err = dp.connect("delete_produced_good", Callable(self, "delete_produced_good"))
	
	for type_factory in factory_goods:
		var factory = type_factory.generate_factory(self, player.economy_manager)
		var _err
		list_of_buildings.append(factory)
		player.economy_manager.factories_list.append(factory)
		append_produced_good(factory.good)
		
		_err = factory.connect("append_produced_good", Callable(self, "append_produced_good"))
		_err = factory.connect("delete_produced_good", Callable(self, "delete_produced_good"))


func set_mask():
	var texture = texture_normal
	var image = texture.get_image()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)
	set_click_mask(bitmap)


func _pressed():
	Players.get_player().window_province.update_information(self)


func set_new_owner(new_owner):
	if player != null:
		player.erase_region(self)
		register_enterprises(new_owner, player)
		set_enterprises_efficiency(new_owner.economy_manager)
	else:
		register_enterprises(new_owner)
	
	player = new_owner
	player.register_region(self)
	change_color_of_region(new_owner.national_color)


func change_color_of_region(color):
	modulate = color


func update_text_on_label():
	name_of_region_label.position = Vector2(size.x / 2, size.y / 2)
	name_of_region_label.set_horizontal_alignment(0)
	name_of_region_label.set_vertical_alignment(0)
	name_of_region_label.text = name_of_tile


func set_default_region():
	change_color_of_region(player.national_color)
	name_of_region_label.text = name_of_tile


func show_name_of_region_label():
	name_of_region_label.text = name_of_tile


func get_production_bonuses_from_railways():
	var factory_production = (railways.level * 0.1)
	var DP_production      = (railways.level * 0.05)
	
	return [
		factory_production,
		DP_production,
	]


func append_produced_good(good):
	produced_goods.append(good)
	set_region_raw_bonus()


func delete_produced_good(good):
	produced_goods.erase(good)
	set_region_raw_bonus()


func set_region_raw_bonus():
	for i in list_of_buildings:
		i.set_region_raw_bonus()


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


func sort_open_factories():
	var last_el = list_of_buildings[-1]
	for j in range(4):
		for factory in list_of_buildings:
			if list_of_buildings.find(factory) != last_el:
				var first = factory
				var second = list_of_buildings[list_of_buildings.find(factory) + 1]
				
				var first_index = list_of_buildings.find(first)
				var second_index = list_of_buildings.find(second)
				
				var first_profit = first.based_profit
				var second_profit = second.based_profit
				
				if first_profit < second_profit: # Если true, то элементы меняем местами
					Functions.swap(first_index, second_index, list_of_buildings)


func build_factory(factory_type):
	var factory = ConstructionProject.new(factory_type, self, player.economy_manager)
	projects_list.append(factory)


func allocate_workers_to_factories():
	for factory in list_of_buildings:
		var avaliable_jobs              = factory.max_employed_number - (factory.workers_quantity + factory.clerks_quantity)
		var avaliable_jobs_for_workers  = snappedf(avaliable_jobs * 0.8, 1)
		var avaliable_jobs_for_clerks   = avaliable_jobs - avaliable_jobs_for_workers
		
		factory.workers_unit.allocate_workers_to_factories(factory, "workers_quantity", avaliable_jobs_for_workers)
		factory.clerks_unit.allocate_workers_to_factories(factory, "clerks_quantity", avaliable_jobs_for_clerks)
		
		avaliable_jobs = factory.max_employed_number - (factory.workers_quantity + factory.clerks_quantity)
		if avaliable_jobs > 0:
			factory.workers_unit.allocate_workers_to_factories(factory, "workers_quantity", avaliable_jobs)

		if factory.workers_unit.unemployed_quantity == 0 and factory.clerks_unit.unemployed_quantity == 0:
			return


func allocate_workers_to_DP():
	var workers_unit = population.population_types[0]
	workers_unit.unemployed_quantity = 0
	for dp in DP_list:
		dp.workers_unit = workers_unit
		dp.workers_quantity = workers_unit.quantity / 2


func get_factories_list():
	return list_of_buildings


func set_enterprises_efficiency(economy_manager):
	#var bonuses_from_railways = get_production_bonuses_from_railways()
	
	for i in get_factories_list() + DP_list:
		i.enterprise_production_efficiency = economy_manager.get_enterprise_efficiency_production(i)
		i.good_production_efficiency       = economy_manager.get_good_production_efficiency(i.good)
		i.based_good_production_efficiency = i.good.get_based_good_production_effiency(i)
		i.production_efficiency            = i.enterprise_production_efficiency + i.good_production_efficiency + i.based_good_production_efficiency
		i.economy_manager                  = economy_manager
		
		if i is Factory:
			i.set_region_raw_bonus()
		#print(i.production_efficiency, " ", i.enterprise_production_efficiency + i.good_production_efficiency + i.based_good_production_efficiency)


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
