extends Panel

signal update(market)

func update_information():
	emit_signal("update", GlobalMarket.prices_of_goods)
