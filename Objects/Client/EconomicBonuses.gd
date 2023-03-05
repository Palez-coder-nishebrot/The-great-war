extends Node

class_name EconomicBonuses

var population_growth:   int = 0
var attraction_migrants: int = 0
var max_railways:        int = 1
var max_infrastructure:  int = 1

var growth_of_inflation:             float = 1.0
var education_efficiency:            float = 1.0
var factories_efficiency_production: float = 0.0
var DP_efficiency_production:        float = 0.0

var factory_efficiency_production: Dictionary = {
	load("res://Resources/Factories/TipesOfFactories/AirplaneFactory.tres"):        0.0,
	load("res://Resources/Factories/TipesOfFactories/AmmoFactory.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/CanningFactory.tres"):         0.0,
	load("res://Resources/Factories/TipesOfFactories/CarsFactory.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/CharcoalFactory.tres"):        0.0,
	load("res://Resources/Factories/TipesOfFactories/ClothesFactory.tres"):         0.0,
	load("res://Resources/Factories/TipesOfFactories/Distillery.tres"):             0.0,
	load("res://Resources/Factories/TipesOfFactories/ElectricalPartsFactory.tres"): 0.0,
	load("res://Resources/Factories/TipesOfFactories/FurnitureFactory.tres"):       0.0,
	load("res://Resources/Factories/TipesOfFactories/FuelFactory.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/GlassFactory.tres"):           0.0,
	load("res://Resources/Factories/TipesOfFactories/LumberPlant.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/MechPartsFactory.tres"):       0.0,
	load("res://Resources/Factories/TipesOfFactories/SentheticOilFactory.tres"):    0.0,
	load("res://Resources/Factories/TipesOfFactories/PhoneFactory.tres"):           0.0,
	load("res://Resources/Factories/TipesOfFactories/RadioFactory.tres"):           0.0,
	load("res://Resources/Factories/TipesOfFactories/RiflesFactory.tres"):          0.0,
	load("res://Resources/Factories/TipesOfFactories/SentheticRubberFactory.tres"): 0.0,
	load("res://Resources/Factories/TipesOfFactories/SaltpeterFactory.tres"):       0.0,
	load("res://Resources/Factories/TipesOfFactories/SentheticTextileFactory.tres"):0.0,
	load("res://Resources/Factories/TipesOfFactories/SteelPlant.tres"):             0.0,
	load("res://Resources/Factories/TipesOfFactories/TankFactory.tres"):            0.0,
	load("res://Resources/Factories/TipesOfFactories/TextileFactory.tres"):         0.0,
}

var goods_efficiency_production: Dictionary = {
	load("res://Resources/Good/alcohol.tres"):0.0,
	load("res://Resources/Good/ammo.tres"):0.0,
	load("res://Resources/Good/artillery.tres"):0.0,
	load("res://Resources/Good/beasts.tres"):0.0,
	load("res://Resources/Good/canned_food.tres"):0.0,
	load("res://Resources/Good/cars.tres"):0.0,
	load("res://Resources/Good/clothes.tres"):0.0,
	load("res://Resources/Good/coal.tres"):0.0,
	load("res://Resources/Good/cotton.tres"):0.0,
	load("res://Resources/Good/el_parts.tres"):0.0,
	load("res://Resources/Good/furniture.tres"):0.0,
	load("res://Resources/Good/gas.tres"):0.0,
	load("res://Resources/Good/glass.tres"):0.0,
	load("res://Resources/Good/grain.tres"):0.0,
	load("res://Resources/Good/iron.tres"):0.0,
	load("res://Resources/Good/lumber.tres"):0.0,
	load("res://Resources/Good/mech_parts.tres"):0.0,
	load("res://Resources/Good/oil.tres"):0.0,
	load("res://Resources/Good/phone.tres"):0.0,
	load("res://Resources/Good/radio.tres"):0.0,
	load("res://Resources/Good/rifles.tres"):0.0,
	load("res://Resources/Good/rubber.tres"):0.0,
	load("res://Resources/Good/saltpeter.tres"):0.0,
	load("res://Resources/Good/steel.tres"):0.0,
	load("res://Resources/Good/tanks.tres"):0.0,
	load("res://Resources/Good/textile.tres"):0.0,
	load("res://Resources/Good/wood.tres"):0.0,
}

var list_of_buildings: Array = [
	load("res://Resources/Factories/TipesOfFactories/AirplaneFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/AmmoFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/CanningFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/CarsFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/CharcoalFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/ClothesFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/Distillery.tres"),
	load("res://Resources/Factories/TipesOfFactories/ElectricalPartsFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/FurnitureFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/FuelFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/GlassFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/LumberPlant.tres"),
	load("res://Resources/Factories/TipesOfFactories/MechPartsFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SentheticOilFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/PhoneFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/RadioFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/RiflesFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SentheticRubberFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SaltpeterFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SentheticTextileFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/SteelPlant.tres"),
	load("res://Resources/Factories/TipesOfFactories/TankFactory.tres"),
	load("res://Resources/Factories/TipesOfFactories/TextileFactory.tres"),
]


func _init():
	set_list_of_buildings()


func set_list_of_buildings():
	var list = []
	
	for file in list_of_buildings:
		var factory = Factory.new()
		
		factory.name_of_factory = file.name_of_factory
		factory.good = file.good
		factory.type_factory = file
		factory.raw = file.raw
		list.append(factory)
	list_of_buildings = list


func find_factory(name_of_factory):
	for i in list_of_buildings:
		if i.name_of_factory == name_of_factory:
			return i


func get_profit_of_factory(name_of_factory):
	var region = Players.player.list_of_tiles[0]
	var factory = find_factory(name_of_factory)
	factory.province = region
	factory.quantity_of_workers = 1.0
	var player = region.player
	
	var workers = 1.0
	var quantity_of_good = factory.get_quanity_of_good()
	var expenses = (player.game.factory_manager.min_salary + player.min_salary) * workers
	#expenses    += get_expenses_on_raw(factory.purchase) + get_expenses_on_based_goods(factory)
	
	var income   = quantity_of_good * GlobalMarket.prices_of_goods[factory.good]
	var profit   = income - expenses
	
	factory.province = Node
	factory.quantity_of_workers = 0.0
	return profit
	

func get_expenses_on_raw(raw_list):
	var cost = 0.0
	for i in raw_list:
		cost += GlobalMarket.prices_of_goods[i] * raw_list[i]
	return cost


func get_expenses_on_based_goods(factory):
	var cost = 0.0
	for i in factory.list_of_mechanisms:
		cost += GlobalMarket.prices_of_goods[i] * factory.quantity_of_based_goods
	return cost
