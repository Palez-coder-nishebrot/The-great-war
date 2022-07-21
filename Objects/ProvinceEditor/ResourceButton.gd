extends Button


func _ready():
	icon = load(Players.sprites_of_goods[name])
	connect("pressed", self, "button_pressed")

func button_pressed():
	get_parent().get_parent().append_resource_to_tile(name)
