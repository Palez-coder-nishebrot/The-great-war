extends HBoxContainer

@export var icon: CompressedTexture2D
var text: String = "":
	set(value):
		$Label.text = value

func _ready():
	$TextureRect.texture = icon
