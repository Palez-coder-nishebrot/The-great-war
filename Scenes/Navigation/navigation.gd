extends Node

export(NodePath) var tile_container_np

const CHECKER_GROW_SIZE = Vector2(150, 150)
var CollideCollector = preload("res://Scenes/Navigation/collide_collector.gd")

var _tiles = []
var _tiles_mu = Mutex.new()
var _physics_space
var _threads = []
var _collisions_collection_node
var _navigation_checker_area_script = preload("res://Scenes/Navigation/navigation_checker_area.gd")


func _ready():
	create_thread_pool()
	
	_physics_space = Physics2DServer.space_create()
	Physics2DServer.space_set_active(_physics_space, true)
	
	var container = get_node(tile_container_np)
	_collisions_collection_node = container.get_node("DebugCollisionView")

	for ch in container.get_children():
		if ch is TextureButton:
			_tiles.append(ch)

#	_cteate_polygons()
	for t in _threads:
		t.start(self, "_cteate_polygons")


func _exit_tree():
	for t in _threads:
		t.wait_to_finish()


func _cteate_polygons():
	while true:
		print("test ", _tiles.size())
		_tiles_mu.lock()
		var tile = _tiles.pop_back()
		_tiles_mu.unlock()
		
		if tile == null:
			break
		
		var raw_image = tile.texture_normal.get_data() as Image
		var s = raw_image.get_size()
		raw_image.resize(s.x + CHECKER_GROW_SIZE.x, s.y + CHECKER_GROW_SIZE.y, Image.INTERPOLATE_NEAREST)
		
		var bm = BitMap.new()
		bm.create_from_image_alpha(raw_image)
		
		var polygons = bm.opaque_to_polygons(Rect2(Vector2.ZERO, bm.get_size()))
		var tile_area = Area2D.new()
		tile_area.set_script(_navigation_checker_area_script)
		tile_area.tile = tile
		
		Physics2DServer.area_set_transform(tile_area, Transform2D(0, tile.rect_global_position - CHECKER_GROW_SIZE / 2))
		Physics2DServer.area_set_collision_layer(tile_area, 1)
		Physics2DServer.area_set_collision_mask(tile_area, 1)
		Physics2DServer.area_set_monitorable(tile_area, true)
		Physics2DServer.area_set_space(tile_area, _physics_space)
		
		for poly in polygons:
			var shape = Physics2DServer.convex_polygon_shape_create()
			Physics2DServer.shape_set_data(shape, poly)
			Physics2DServer.area_add_shape(tile_area, shape)
		
		var collector = CollideCollector.new()
		collector.tile = tile
		
		Physics2DServer.area_set_area_monitor_callback(tile_area, collector, "_on_navigation_tile_monitor")


func create_thread_pool():
	var processors = OS.get_processor_count() - 1
	
	for _i in processors:
		_threads.append(Thread.new())
