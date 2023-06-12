@tool

extends TextureRect

@export var good: Good

@onready var parent = get_parent().get_parent()
@onready var good_sprite = $HBoxContainer/good_sprite
@onready var cost = $HBoxContainer/VBoxContainer/Cost
@onready var import = $HBoxContainer/VBoxContainer/Import
@onready var production = $HBoxContainer/VBoxContainer/Production

func _ready():
#	var image = good.icon.get_image()
#	var text_re = ImageTexture.create_from_image(image)
#	good_sprite.texture = text_re
	good_sprite.icon =  good.icon
	parent.connect("update", update_information)
	

func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		#parent.good = good
		parent.update_information_about_good(good)
#	if pressed == true:
#		parent.update_information_about_good(good)


func update_information():
	var player = Players.player
	cost.text = "Цена: " + str(player.economy_manager.prices_goods[good])
	production.text = "Пр-во: " + str(player.economy_manager.production_goods[good])
	
	var im = player.import_goods[good]
	var ex = player.export_goods[good]
	
	if im > ex:
		import.text = "Имп: " + str(im)
	else:
		import.text = "Экс: " + str(ex)
