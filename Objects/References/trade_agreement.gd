extends Reference

class_name TradeAgreement

var seller:   Client
var customer: Client # Покупатель/заказчик

var good: Resource
var quantity: float


func move_goods_to_customer():
	customer.local_market[good] += quantity
