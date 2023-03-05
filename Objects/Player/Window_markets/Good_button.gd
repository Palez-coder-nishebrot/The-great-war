extends Panel

export var good: Resource

onready var parent = get_parent().get_parent().get_parent()
onready var image = $TextureRect
onready var cost = $Cost
onready var import = $Import
onready var production = $Production

func _ready():
	image.icon = good.icon
	#parent.connect("update", self, "update_information")
	

func _gui_input(event):
	if event is InputEventMouseButton and image.pressed:
		#parent.good = good
		parent.update_information_about_good(good)
#	if pressed == true:
#		parent.update_information_about_good(good)


func update_information():
	var player = Players.player
	cost.text = "Цена: " + str(player.prices_goods[good])
	production.text = "Пр-во: " + str(player.production_goods[good])
	
	var im = player.import_goods[good]
	var ex = player.export_goods[good]
	
	if im > ex:
		import.text = "Имп: " + str(im)
	else:
		import.text = "Экс: " + str(ex)
