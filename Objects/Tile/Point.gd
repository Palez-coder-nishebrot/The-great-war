@tool
extends TextureButton

class_name Province

const max_of_buildings: int = 8

var neighbors_tiles:            Array[Province]            = []
var list_of_units:              Array                      = []

@export var name_of_tile: String = ""
var capital:             bool   = false
var player:              Object
var training_units:      Object

var railways:               Object = Railways.new()
var infrastructure:         Object = Infrastructure.new()
var landscape:              Object = Landscape.new()

@onready var name_of_region_label: Object = $Label
@onready var area:     Area2D             = $Area2D
@onready var collision:CollisionPolygon2D = $Area2D/CollisionPolygon2D
var sprite_of_resource: Sprite2D


func _ready():
	name_of_tile = name
	texture_normal = load("res://Graphics/Sprites/world_regions/" + name + ".png")
	name_of_region_label.position = Vector2(size.x / 2, size.y / 2)
	name_of_region_label.set_horizontal_alignment(0)
	name_of_region_label.set_vertical_alignment(0)
	name_of_region_label.text = name
	set_mask()
	update_text_on_label()


func add_neighbors(neighbor: Province):
	neighbors_tiles.append(neighbor)


func add_debug_collider(polygon, global_pos):
	var collision = CollisionPolygon2D.new()
	collision.global_position = global_pos
	collision.polygon = polygon
	add_child(collision)


func set_mask():
	var texture = texture_normal
	var image = texture.get_image()
	var bitmap = BitMap.new()
	bitmap.create_from_image_alpha(image)
	set_click_mask(bitmap)


func _pressed():
	Players.get_player().window_province.update_information(self)


func set_region_color(color):
	modulate = color


func update_text_on_label():
	name_of_region_label.position = Vector2(size.x / 2, size.y / 2)
	name_of_region_label.set_horizontal_alignment(0)
	name_of_region_label.set_vertical_alignment(0)
	name_of_region_label.text = name_of_tile


func set_default_region():
	set_region_color(player.national_color)
	name_of_region_label.text = name_of_tile


func show_name_of_region_label():
	name_of_region_label.text = name_of_tile

