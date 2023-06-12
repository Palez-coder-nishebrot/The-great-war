extends RefCounted

class_name TradeAgreement

var seller
var customer # Покупатель/заказчик

var good: Resource
var quantity: float

func _init(seller_, customer_, good_, quantity):
	seller = seller_
	customer = customer_
	good = good_
	quantity = quantity


func move_goods_to_customer(quantity):
	customer.demand_supply_goods[good][1] += quantity
	seller.demand_supply_goods[good][0] += quantity
	
	customer.local_market[good] += quantity
	seller.local_market[good] -= quantity


func break_contract():
	customer.trade_agreements[good].erase(self)
	seller.trade_agreements[good].erase(self)
	free()
