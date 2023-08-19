@tool

extends TextureButton

@export var text: String = ""

@onready var label = $Label

func _ready():
	label.text = text
