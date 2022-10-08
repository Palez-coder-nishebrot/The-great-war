extends Button

var good: String


func start(parent):
	parent.connect("update_info_about_warhouse", self, "update_")
	icon = load(Players.sprites_of_goods[good])


func update_(market_):
	text = "+" + str(market_[good])
