extends TechnologyEffect

class_name TechnologyEffectProductionGoods

@export var name_of_effect: String = "Выпуск продукции"

@export var power: float = 0.0

@export var target: Resource


func get_effect():
	var bonus = (power - 1.0) * 100
	return name_of_effect + " " + target.name + ": +" + str(bonus) + "%"


func activate_effects(client):
	var bonus = power - 1
	client.economic_bonuses.goods_from_technologies[target] += power
