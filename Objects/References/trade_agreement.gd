extends RefCounted

class_name TradeAgreement

var seller
var customer # Покупатель/заказчик

var good: Resource
var quantity: float = 1.0
var contract_is_valid: bool = true


func _init(seller_, customer_, good_, quantity_):
	print("Контракт подписан")
	seller = seller_
	customer = customer_
	good = good_
	quantity = quantity_
	
	seller.trade_agreements_manager.trade_agreements.append(self)
	customer.trade_agreements_manager.trade_agreements.append(self)
	seller.economy_manager.goods_for_sale[good] -= quantity
	#print("Контракт подписан! ", seller.economy_manager.goods_for_sale[good], " ", quantity)


func move_goods_to_customer():
	customer.economy_manager.demand_supply_goods[good][1] += quantity
	seller.economy_manager.demand_supply_goods[good][0] += quantity
	
	customer.economy_manager.import_goods[good] += quantity
	customer.economy_manager.local_market[good] += quantity
	seller.economy_manager.goods_for_sale[good] -= quantity
	

func break_contract():
	contract_is_valid = false
	customer.trade_agreements_manager.trade_agreements.erase(self)
	seller.trade_agreements_manager.trade_agreements.erase(self)
	print("Контракт расторгнут")
