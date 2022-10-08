extends Node

const list_of_players_on_start: Dictionary = {
	"Суеция": {
		"Идеология": "Популисты",
		"Цвет": Color(0, 0.415686, 1),
		"Режим": "Республика",
	},
	
	"Роксолания": {
		"Идеология": "Популисты",
		"Цвет": Color(0, 0.415686, 1),
		"Режим": "Республика",
	},
	
	"Хорезм": {
		"Идеология": "Популисты",
		"Цвет": Color(0.556863, 0.447059, 0.431373),
		"Режим": "Монархия",
		}, 
	
	"Горния": {
		"Идеология": "Популисты",
		"Цвет": Color(0, 0.566406, 0.207977),
		"Режим": "Монархия",
		},
	
	"Баскония": {
		"Идеология": "Популисты",
		"Цвет": Color(0.323029, 0.566406, 0),
		"Режим": "Монархия",
		},
	
	"СЗ": {
		"Идеология": "Популисты",
		"Цвет": Color(0.745694, 0.757813, 0.370026),
		"Режим": "Военная_диктатура",
		},
	
	"Кракожия": {
		"Идеология": "Популисты",
		"Цвет": Color(0, 0.415686, 1),
		"Режим": "Республика",
		},
	
	"Баскакская Торговая Компания": {
		"Идеология": "Популисты",
		"Цвет": Color(0.710938, 0.44989, 0),
		"Режим": "Военная_диктатура",
		},
	
	"Баскакия": {
		"Идеология": "Популисты",
		"Цвет": Color(0.664063, 0.217896, 0),
		"Режим": "Военная_диктатура",
		},
	
	"Поляния": {
		"Идеология": "Либералы",
		"Цвет": Color(0.742188, 0.086975, 0.086975),
		"Режим": "Республика",
		},
	
	"Амани": {
		"Идеология": "Популисты",
		"Цвет": Color(0, 0.472656, 0.461578),
		"Режим": "Монархия",
		},
	
	"Адамантия": {
		"Идеология": "Либералы",
		"Цвет": Color(0.342934, 0.172577, 0.679688),
		"Режим": "Республика",
		},
	
	"Кавардация": {
		"Идеология": "Популисты",
		"Цвет": Color(0.691406, 0.245773, 0.444219),
		"Режим": "Республика",
		},
	
	"Насардия": {
		"Идеология": "Либералы",
		"Цвет": Color(0.257126, 0.535156, 0.483026),
		"Режим": "Республика",
		},
	
	"Тернокат": {
		"Идеология": "Социалисты",
		"Цвет": Color(0.78125, 0.439453, 0),
		"Режим": "Советская_республика",
		},
	
	"Иллирия": { #Западный Азис
		"Идеология": "Популисты", 
		"Цвет": Color(0.381058, 0.479009, 0.863281),
		"Режим": "Республика",
		},

	"Теверция": { #Третья Поляния
		"Идеология": "Популисты",
		"Цвет": Color(0.40543, 0.65625, 0.397339),
		"Режим": "Монархия",
		},
	
	"Кривечия": {
		"Идеология": "Либералы",
		"Цвет": Color(1, 0.402344, 0.402344),
		"Режим": "Республика",
		},
	
	"Зличания": { #Вольная Поляния
		"Идеология": "Популисты",
		"Цвет": Color(0.735621, 0.340866, 0.980469),
		"Режим": "Республика",
		},
}



const accounting: Dictionary = {
	"Субсидии":             0,
	"Военное_производство": 0,
	
	"Образование":          0,
	"Здравохранение":       0,
	"Пенсии":               0,
	"Пособия_по_безработице":0,
	"Снабжение_армии":       0,
	
	"Пошлины": 0,
	"Налоги_на_бедных":     0,
	"Налоги_на_богатых":    0,
	"Продажа_драгметаллов": 0,
	"Производство":         0,
	"Закупка_сырья_для_ЖД": 0,
}



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


const sprites_of_goods: Dictionary = {
	"coal":     "res://Graphics/Sprites/Goods/Coal.png",
	"iron":    "res://Graphics/Sprites/Goods/Iron.png",
	"oil":     "res://Graphics/Sprites/Goods/Oil.png",
	"rubber":    "res://Graphics/Sprites/Goods/Rubber.png",
	"cotton":    "res://Graphics/Sprites/Goods/Cotton.png",
	"grain":     "res://Graphics/Sprites/Goods/Seed.png",
	"beasts":      "res://Graphics/Sprites/Goods/Cattle.png",
	"saltpeter":   "res://Graphics/Sprites/Goods/Nitrate.png",
	"wood": "res://Graphics/Sprites/Goods/Wood.png",
	
	"steel":           "res://Graphics/Sprites/Goods/Steel.png",
	"glass":          "res://Graphics/Sprites/Goods/Glass.png",
	"textile":           "res://Graphics/Sprites/Goods/Fabric.png",
	"el_parts": "res://Graphics/Sprites/Goods/Electric parts.png",
	#"Удобрения":       "res://Graphics/Sprites/Goods/Fertilizer.png",
	"lumber":   "res://Graphics/Sprites/Goods/Lumber.png",
	
	"cars":      "res://Graphics/Sprites/Goods/Car.png",
	"telegraphs":       "res://Graphics/Sprites/Goods/Telegraph.png",
	"phone":        "res://Graphics/Sprites/Goods/Phone.png",
	"radio":           "res://Graphics/Sprites/Goods/Radio.png",
	"el_appliances":  "res://Graphics/Sprites/Goods/El-appliances.png",
	
	"furniture":          "res://Graphics/Sprites/Goods/Furniture.png",
	"alcohol":        "res://Graphics/Sprites/Goods/Alhohol.png",
	"clothes":          "res://Graphics/Sprites/Goods/Clothes.png",
	"canned_food":        "res://Graphics/Sprites/Goods/Canned food.png",
	"gas":         "res://Graphics/Sprites/Goods/Gas.png",
	"tabaco":           "res://Graphics/Sprites/Goods/Tabaco.png",
	"tea":             "res://Graphics/Sprites/Goods/Tea.png",
	#"Кофе":            "res://Graphics/Sprites/Goods/Coffee.png", 
	#"Обогреватели":  "res://Graphics/Sprites/Goods/Coffee.png", 
	
	"projectiles":             "res://Graphics/Sprites/Goods/Shells.png",
	"ammo":          "res://Graphics/Sprites/Goods/Ammunition.png",
	"machine_guns":            "res://Graphics/Sprites/Goods/Machine gun.png",
	"artillery":          "res://Graphics/Sprites/Goods/Artillery.png",
	"plane":            "res://Graphics/Sprites/Goods/Airplane.png",
	"rifles": "res://Graphics/Sprites/Goods/Bolt-action rifle.png",
	"armored_cars":         "res://Graphics/Sprites/Goods/Armored car.png",
	"tanks":               "res://Graphics/Sprites/Goods/Tank.png",
}


const output: Dictionary = {
	"coal":     0,
	"iron":    0,
	"oil":     0,
	"rubber":    0,
	"cotton":    0,
	"grain":     0,
	"beasts":      0,
	"saltpeter":   0,
	"wood": 0,
	
	"steel":           0,
	"glass":          0,
	"textile":           0,
	"el_parts": 0,
	"lumber":   0,
	
	"cars":      0,
	"telegraphs":       0,
	"phone":        0,
	"radio":           0,
	"el_appliances":  0,
	
	"furniture":          0,
	"alcohol":        0,
	"clothes":          0,
	"canned_food":        0,
	"gas":         0,
	"tabaco":           0,
	"tea":             0,
	
	"projectiles":             0,
	"ammo":          0,
	"machine_guns":            0,
	"artillery":          0,
	"plane":            0,
	"rifles": 0,
	"armored_cars":         0,
	"tanks":               0,
}


const list_of_units: Array = [
	"plane-разведчик",
	"Боевой plane",
	"plane-истребитель",
	"Бомбардировщик",
	
	"Фронтовики", 
	"Гренадеры", #Штурмовая пехота
	"artillery",
	
	"Кавалерия",
	"armored_cars",
	"tanks",
	
	"Подводная лодка",
	"Рейдер",
	
	"Дредноут",
	"Броненосец",
	"Крейсер смерти",
	"Броненосец смерти",
]


const fleet_units: Array = [
	"Подводная лодка",
	"Рейдер",
	"Дредноут",
	"Броненосец",
	"Крейсер смерти",
	"Броненосец смерти",
]


const units_for_training: Array = [
	"plane-разведчик",
	"Фронтовики",
	"artillery",
	"Кавалерия",
	"Подводная лодка",
	"Рейдер",
]


const levels_of_technologies: Dictionary = {
	"Фабричное производство":    0,
	"Фермерское производство":   0,
	"Добыча":                    0,
	"Инфраструктура и снабжение":0,
	
	"Управление армией":         0,
	"Техника":                   0,
	"Тяжелое вооружение":        0,
	"Легкое вооружение":         0,
	"Флот":                      0,
}


var not_factories: Array = ["Military_factory", "Navy_factory"]

var country_to_start: String = ""
var player:           Object


var list_of_players:  Array = []


func find_client(name_of_state):
	for i in list_of_players:
		if i.name_of_country == name_of_state:
			return i
