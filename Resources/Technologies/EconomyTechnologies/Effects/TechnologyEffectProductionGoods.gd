extends TechnologyEffect

class_name TechnologyEffectProductionGoods

export(String) var name_of_effect = "Выпуск продукции"

export(float) var power = 0.0

export(Resource) var target


func get_effect():
	var bonus = (power - 1.0) * 100
	return name_of_effect + " " + target.name + ": +" + str(bonus) + "%"


func activate_effects(client):
	var bonus = power - 1
	client.economic_bonuses.goods_from_technologies[target] += power
