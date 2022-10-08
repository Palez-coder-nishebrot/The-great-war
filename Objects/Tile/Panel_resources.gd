extends Panel

const sprites_of_resources: Dictionary = {
	"Уголь":     "res://Graphics/Sprites/Goods/coal.png",
	"Железо":    "res://Graphics/Sprites/Goods/iron.png",
	"Нефть":     "res://Graphics/Sprites/Goods/oil.png",
	"Резина":    "res://Graphics/Sprites/Goods/rubber.png",
	
	"Хлопок":    "res://Graphics/Sprites/Goods/cotton.png",
	"Зерно":     "res://Graphics/Sprites/Goods/steel.png",
	"Скот":      "res://Graphics/Sprites/Goods/steel.png",
	"Селитра":   "res://Graphics/Sprites/Goods/saltpeter.png",
	"Древесина": "res://Graphics/Sprites/Goods/wood.png",
}

onready var links: Dictionary = {
	$HBoxContainer/Label:  $TextureRect,
	$HBoxContainer/Label2: $TextureRect2,
}

func update_information():
	var resources = get_parent().resources
	var token = 0
	for i in resources:
		var label = links.keys()[0]
		label.text = str(resources[i])
		links[label].texture = load(sprites_of_resources[i])
