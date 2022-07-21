extends Button

var good = name


func _ready():
	good = name
	icon = load(Players.sprites_of_goods[name])
	connect("pressed", self, "button_pressed")


func button_pressed():
		get_parent().get_parent().get_parent().append_factory_to_tile(good)
