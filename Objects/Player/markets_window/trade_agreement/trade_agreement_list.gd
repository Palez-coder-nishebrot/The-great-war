extends VBoxContainer

signal update_labels

var label_path = "res://Objects/Player/Window_markets/trade_agreement/trade_agreement.tscn"

var trade_agreements_in_list: Array = []


func update():
	emit_signal("update_labels")
	#is_instance_valid()
	var list = Players.get_player_client().trade_agreements_manager.trade_agreements
	
	for i in list:
		if not trade_agreements_in_list.has(i):
			spawn_trade_agreement_label(i)
			trade_agreements_in_list.append(i)


func spawn_trade_agreement_label(trade_agreement):
	var label: Object = load(label_path).instantiate()
	var client
	
	if trade_agreement.seller == Players.get_player_client():
		client = trade_agreement.customer
	else:
		client = trade_agreement.seller
	
	label.set_values(client, trade_agreement, trade_agreement.good, trade_agreement.quantity)
	
	connect("update_labels", Callable(label, "update"))
	
	add_child(label)
