extends HBoxContainer


@onready var texture_rect = $TextureRect
@onready var label = $Label

@export var icon: Resource


func _ready():
	texture_rect.texture = icon


func set_data(text, new_icon = null):
	label.text = str(text)
	if new_icon != null:
		texture_rect.texture = new_icon
