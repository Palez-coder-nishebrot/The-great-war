extends TechnologyEffect

class_name TechnologyEffectProductionGoods

@export var name_of_effect: String = "Выпуск продукции"

@export var power: float = 0.0

@export var target: Resource


func get_effect():
	var bonus = power * 100
	return name_of_effect + " " + target.name + ": +" + str(bonus) + "%"


func activate_effects(client):
	client.economy_manager.production_efficiency_manager.production_goods_efficiency[target] += power
