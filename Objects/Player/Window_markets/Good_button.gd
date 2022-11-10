extends Panel

export var good: String = ""

onready var parent = get_parent().get_parent().get_parent()
onready var image = $TextureRect
onready var cost = $Cost
onready var import = $Import
onready var production = $Production

func _ready():
	image.icon = load(Players.sprites_of_goods[good])
	parent.connect("update", self, "update_information")
	

func _gui_input(event):
	if event is InputEventMouseButton and image.pressed:
		parent.good = good
#	if pressed == true:
#		parent.update_information_about_good(good)


func update_information():
	cost.text = "Цена: " + str(GlobalMarket.prices_of_goods[good])
	production.text = "Пр-во: " + str(Players.player.output[good])
	
	var im = Players.player.import_of_goods[good]
	var ex = Players.player.export_of_goods[good]
	
	if im > ex:
		import.text = "Имп: " + str(im)
	else:
		import.text = "Экс: " + str(ex)
