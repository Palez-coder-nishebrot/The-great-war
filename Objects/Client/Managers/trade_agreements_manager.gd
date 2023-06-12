extends Node


class_name TradeAgreementsManager

var client
var trade_agreements: Dictionary = {
	load("res://Resources/Factories/TipesOfFactories/AirplaneFactory.tres"):        [],
	load("res://Resources/Factories/TipesOfFactories/AmmoFactory.tres"):            [],
	load("res://Resources/Factories/TipesOfFactories/CanningFactory.tres"):         [],
	load("res://Resources/Factories/TipesOfFactories/CarsFactory.tres"):            [],
	load("res://Resources/Factories/TipesOfFactories/CharcoalFactory.tres"):        [],
	load("res://Resources/Factories/TipesOfFactories/ClothesFactory.tres"):         [],
	load("res://Resources/Factories/TipesOfFactories/Distillery.tres"):             [],
	load("res://Resources/Factories/TipesOfFactories/ElectricalPartsFactory.tres"): [],
	load("res://Resources/Factories/TipesOfFactories/FurnitureFactory.tres"):       [],
	load("res://Resources/Factories/TipesOfFactories/FuelFactory.tres"):            [],
	load("res://Resources/Factories/TipesOfFactories/GlassFactory.tres"):           [],
	load("res://Resources/Factories/TipesOfFactories/LumberPlant.tres"):            [],
	load("res://Resources/Factories/TipesOfFactories/MechPartsFactory.tres"):       [],
	load("res://Resources/Factories/TipesOfFactories/SentheticOilFactory.tres"):    [],
	load("res://Resources/Factories/TipesOfFactories/PhoneFactory.tres"):           [],
	load("res://Resources/Factories/TipesOfFactories/RadioFactory.tres"):           [],
	load("res://Resources/Factories/TipesOfFactories/RiflesFactory.tres"):          [],
	load("res://Resources/Factories/TipesOfFactories/SentheticRubberFactory.tres"): [],
	load("res://Resources/Factories/TipesOfFactories/SaltpeterFactory.tres"):       [],
	load("res://Resources/Factories/TipesOfFactories/SentheticTextileFactory.tres"):[],
	load("res://Resources/Factories/TipesOfFactories/SteelPlant.tres"):             [],
	load("res://Resources/Factories/TipesOfFactories/TankFactory.tres"):            [],
	load("res://Resources/Factories/TipesOfFactories/TextileFactory.tres"):         [],
}


func _init(player):
	client = player


func execute_contracts():
	for contract in client.trade_agreements:
		if contract.seller == client:
			execute_contract(contract)


func execute_contract(contract):
	var seller   = contract.seller
	var good     = contract.good
	var quantity = contract.quantity
	
	if seller.local_market[good] >= quantity:
		contract.move_goods_to_customer(quantity)
	else: # Нарушили контракт!
		var new_quantity = seller.local_market[good]
		contract.move_goods_to_customer(new_quantity)
		contract.break_contract()


func sign_new_contracts(client):
	var economy_manager = client.economy_manager
	var s_d_goods = economy_manager.demand_supply_goods
	for good in s_d_goods:
		var supply = s_d_goods[1]
		var demand = s_d_goods[0]
		
		if demand > supply:
			find_country_seller(good, demand - supply)
		
			
func find_country_seller(good, quantity):
	var need_quantity = quantity
	var country_rating = client.get_parent().get_parent().country_rating_by_selling_goods
	for player in country_rating:
		if player != client:
			var economy_manager = player.economy_manager
			var surplus = economy_manager.production_goods[good] - economy_manager.demand_supply_goods[0]
			if surplus > 0:
				if surplus >= need_quantity:
					TradeAgreement.new(player, client, good, need_quantity)
					need_quantity = 0
				else:
					TradeAgreement.new(player, client, good, surplus)
					need_quantity - surplus
			
			if need_quantity == 0:
				break
				
			
