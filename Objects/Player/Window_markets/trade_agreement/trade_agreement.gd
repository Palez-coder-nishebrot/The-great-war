extends HBoxContainer


var country: Object
var good: Resource
var quantity: float
var trade_agreement: TradeAgreement

@onready var icon = $TextureRect
@onready var quantity_label = $quantity
@onready var country_label = $country


func set_values(client, trade_agreement_, good_, q):
	country = client
	good = good_
	quantity = q
	trade_agreement = trade_agreement_
	
	$country.text = country.name_of_country


func update():
	if trade_agreement.contract_is_valid == false:
		queue_free()
	
	set_info()


func set_info():
	icon.texture = good.icon
	quantity_label.text = str(quantity)
	country_label.text = country.name_of_country
