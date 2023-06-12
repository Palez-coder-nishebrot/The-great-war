extends TextureButton


var list_of_buildings:          Array      = []
var list_of_households:         Array      = []

var quantity_of_factory_workers: int = 0
var quantity_of_workers: int = 0
var quantity_of_clerks: int = 0

var name_of_region: String
var landscape:           String = "Степь"
var editor:              Object
var resources:           Array = []
var railways: int = 0

@onready var label = $Label
#onready var collision = $Area2D/CollisionPolygon2D
@onready var map_editor = get_parent().get_node("ClientEditor")

#func _gui_input(event):
#	if event is InputEventMouseButton and pressed:
#		breakpoint
#		  # etc

#func input(viewport, event, shape_idx):
#	if event is InputEventMouseButton and event.pressed:
#		if event.button_index == BUTTON_LEFT:
#			map_editor.region_panel.set_info_about_region(self)


func _pressed():
	map_editor.region_panel.set_info_about_region(self)


func set_mask():
	var texture = texture_normal
	var data = texture.get_data()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(data)
	set_click_mask(bitmap)
