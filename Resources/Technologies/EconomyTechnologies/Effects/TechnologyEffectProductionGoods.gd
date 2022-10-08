extends TechnologyEffect

class_name TechnologyEffectProductionGoods

export(String) var name_of_effect = "Выпуск продукции"

export(int) var power = 0

export(String, "iron", "coal", "rubber", "oil", "steel", "glass", "gas",
	"electronics", "beasts", "grain") var target = "iron"


func get_effect():
	return name_of_effect + " " + list_of_points_of_effect[target] + ": +" + str(power) + "%"


func activate_effects(client):
	client.economic_bonuses.goods_from_technologies[target] += power / 10
