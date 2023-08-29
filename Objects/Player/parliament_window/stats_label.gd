extends HBoxContainer

@export var icon: CompressedTexture2D
@export var value_name: String = ""


func set_text(value):
	$Label.text  = tr(value_name) + ": "
	$Label2.text = str(value)


func _ready():
	$TextureRect.texture = icon
