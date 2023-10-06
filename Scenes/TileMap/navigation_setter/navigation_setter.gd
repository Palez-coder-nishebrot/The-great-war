extends Node


const CHECKER_GROW_SIZE = Vector2(25, 25)

var thread = Thread.new()
var mutex = Mutex.new()


func start():
	create_polygons()
	#thread.start(create_polygons)


func create_polygons():
	for province in SceneStorage.regions_manager.province_list:
		create_polygon(province)


func create_polygon(province: Province):
	var raw_image = province.texture_normal.get_image()
	#raw_image = raw_image.get_data()
	var s = raw_image.get_size()
	
	var bitmap    = BitMap.new()
	bitmap.create_from_image_alpha(raw_image)
	
	var polygons = bitmap.opaque_to_polygons(Rect2(Vector2.ZERO, province.texture_normal.get_size()))
	
	province.collision.polygon = polygons[0]


func _exit_tree():
	thread.wait_to_finish()
