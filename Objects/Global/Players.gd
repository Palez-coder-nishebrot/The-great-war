extends Node


const goods_to_factory: Dictionary = {
	"steel":           "Steel_plant",
	"textile":           "Textile_factory",
	"glass":          "Glass_factory",
	"el_appliances": "Electrical_appliance_factory",
	"el_parts":      "Electrical_parts_factory",
	"lumber":   "Lumber_plant",
	"cars":      "Cars_factory",
	"telegraphs":       "Telegraph_factory",
	"phone":        "Phone_factory",
	"radio":           "Radio_factory",
	"furniture":          "Furniture_factory",
	"alcohol":        "Distillery",
	"clothes":          "Clothes_factory",
	"canned_food":        "Canning_factory",
	"gas":         "Gas_factory",
	"plane":        "Airplane_factory",
	
	"rubber":          "Rubber_factory",
	"oil":           "Oil_factory",

}


#const sprites_of_goods: Dictionary = {
#	"coal":     "res://Graphics/Sprites/NewSpritesOfGoods/Coal.png",
#	"iron":    "res://Graphics/Sprites/NewSpritesOfGoods/Iron.png",
#	"oil":     "res://Graphics/Sprites/NewSpritesOfGoods/Oil.png",
#	"rubber":    "res://Graphics/Sprites/NewSpritesOfGoods/Rubber.png",
#	"cotton":   "res://Graphics/Sprites/NewSpritesOfGoods/Cotton.png",
#	"grain":    "res://Graphics/Sprites/NewSpritesOfGoods/Grain.png",
#	"beasts":      "res://Graphics/Sprites/NewSpritesOfGoods/Cattle.png",
#	"saltpeter":   "res://Graphics/Sprites/NewSpritesOfGoods/Nitrate.png",
#	"wood":"res://Graphics/Sprites/NewSpritesOfGoods/Wood.png",
#
#	"steel":           "res://Graphics/Sprites/NewSpritesOfGoods/Steel.png",
#	"glass":          "res://Graphics/Sprites/NewSpritesOfGoods/Glass.png",
#	"textile":           "res://Graphics/Sprites/NewSpritesOfGoods/Fabric.png",
#	"el_parts": "res://Graphics/Sprites/NewSpritesOfGoods/Electric parts.png",
#	"mech_parts": "res://Graphics/Sprites/NewSpritesOfGoods/Mech parts.png",
#	#"Удобрения":       "res://Graphics/Sprites/Goods/Fertilizer.png",
#	"lumber":   "res://Graphics/Sprites/NewSpritesOfGoods/Lumber.png",
#
#	"cars":      "res://Graphics/Sprites/NewSpritesOfGoods/Cars.png",
#	"telegraphs":       "res://Graphics/Sprites/Goods/Telegraph.png",
#	"phone":        "res://Graphics/Sprites/NewSpritesOfGoods/Phone.png",
#	"radio":           "res://Graphics/Sprites/NewSpritesOfGoods/Radio.png",
#	"el_appliances":  "res://Graphics/Sprites/NewSpritesOfGoods/El_appliances.png",
#
#	"furniture":          "res://Graphics/Sprites/NewSpritesOfGoods/Furniture.png",
#	"alcohol":       "res://Graphics/Sprites/NewSpritesOfGoods/Alcohol.tga",
#	"clothes":          "res://Graphics/Sprites/NewSpritesOfGoods/Clothes.png",
#	"canned_food":        "res://Graphics/Sprites/NewSpritesOfGoods/Canned food.png",
#	"gas":         "res://Graphics/Sprites/NewSpritesOfGoods/Gas.png",
##	"tabaco":           "res://Graphics/Sprites/Goods/Tabaco.png",
##	"tea":             "res://Graphics/Sprites/Goods/Tea.png",
#	#"Кофе":            "res://Graphics/Sprites/Goods/Coffee.png", 
#	#"Обогреватели":  "res://Graphics/Sprites/Goods/Coffee.png", 
#
#	"projectiles":             "res://Graphics/Sprites/Goods/Shells.png",
#	"ammo":          "res://Graphics/Sprites/Goods/Ammunition.png",
#	"machine_guns":            "res://Graphics/Sprites/Goods/Machine gun.png",
#	"artillery":          "res://Graphics/Sprites/Goods/Artillery.png",
#	"plane":            "res://Graphics/Sprites/NewSpritesOfGoods/Plane.png",
#	"rifles": "res://Graphics/Sprites/Goods/Bolt-action rifle.png",
#	"armored_cars":         "res://Graphics/Sprites/Goods/Armored car.png",
#	"tanks":               "res://Graphics/Sprites/Goods/Tank.png",
#}


#const output: Dictionary = {
#	"res://Resources/Good/coal.tres":       0,
#	"res://Resources/Good/iron.tres":       0,
#	"res://Resources/Good/oil.tres":        0,
#	"res://Resources/Good/rubber.tres":     0,
#	"res://Resources/Good/cotton.tres":     0,
#	"res://Resources/Good/grain.tres":      0,
#	"res://Resources/Good/beasts.tres":     0,
#	"res://Resources/Good/saltpeter.tres":  0,
#	"res://Resources/Good/wood.tres":       0,
#
#	"res://Resources/Good/steel.tres":      0,
#	"res://Resources/Good/glass.tres":      0,
#	"res://Resources/Good/textile.tres":    0,
#	"res://Resources/Good/el_parts.tres":   0,
#	"res://Resources/Good/mech_parts.tres": 0,
#	"res://Resources/Good/lumber.tres":     0,
#
#	"res://Resources/Good/cars.tres":       0,
#	"res://Resources/Good/phone.tres":      0,
#	"res://Resources/Good/radio.tres":      0,
#
#	"res://Resources/Good/furniture.tres":  0,
#	"res://Resources/Good/alcohol.tres":    0,
#	"res://Resources/Good/clothes.tres":    0,
#	"res://Resources/Good/canned_food.tres":0,
#	"res://Resources/Good/gas.tres":        0,
#
#	"res://Resources/Good/ammo.tres":       0,
#	"res://Resources/Good/artillery.tres":  0,
#	"res://Resources/Good/plane.tres":      0,
#	"res://Resources/Good/rifles.tres":     0,
#	"res://Resources/Good/tanks.tres":      0,
#}


var not_factories: Array = ["Military_factory", "Navy_factory"]

var country_to_start: String = ""
var player:           Object


var list_of_players:  Array = []


func find_client(name_of_state):
	for i in list_of_players:
		if i.name_of_country == name_of_state:
			return i
