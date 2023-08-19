extends Panel

signal update

@onready var good_label          = $VBoxContainer2/Label
@onready var demand_label        = $VBoxContainer2/Label2
@onready var supply_label        = $VBoxContainer2/Label3
@onready var prices_label        = $VBoxContainer2/Label4
@onready var warhouse_label      = $VBoxContainer2/Label5
@onready var export_import_label = $VBoxContainer2/Label6
@onready var max_price_label     = $VBoxContainer2/Label7
@onready var goods_on_global_m = $VBoxContainer2/Label8
@onready var goods_on_local_m  = $VBoxContainer2/Label10
@onready var price_with_tariffs     = $VBoxContainer2/Label9


var good: Resource = load("res://Resources/Good/coal.tres")

func update_information():
	emit_signal("update")
	#emit_signal("update_info_about_output", Players.player.output)
	#emit_signal("update_info_about_warhouse", Players.player.warhouse_of_goods)
	
	update_information_about_good(good)


func update_information_about_good(new_good):
	good = new_good
	
	var economy_manager       = Players.get_player_client().economy_manager
	var tariffs               = economy_manager.tariffs
	var local_market_quantity = economy_manager.local_market[good]
	var demand_supply_good    = economy_manager.demand_supply_goods[good]
	var price                 = economy_manager.prices_goods[good]
	#var goods_warhouse       = economy_manager.warhouse_goods[good]
	var import_good           = economy_manager.import_goods[good]
	var export_good           = economy_manager.export_goods[good]
	var q_on_global_m         = GlobalMarket.goods_quantity[good]
	
	var price_w_tar           = Functions.get_good_price(price, 1, 0, economy_manager.tariffs)
	
	good_label.text = good.name
	
	if import_good == 0:
		export_import_label.text = "Экспорт: " + str(export_good) 
	else:
		export_import_label.text = "Импорт: " + str(import_good)
	
	#warhouse_label.text = "Гос. запасы: " + str(goods_warhouse)
	
	demand_label.text = "Спрос:"       + str(demand_supply_good[0])
	supply_label.text = "Предложение:" + str(demand_supply_good[1])
	
	prices_label.text = "Цена отечественном рынке:" + str(price)
	max_price_label.text = "border_price: " + str(get_m_price(demand_supply_good[1], demand_supply_good[0]))
	goods_on_global_m.text = "Кол-во на глобальном рынке: " + str(q_on_global_m)
	price_with_tariffs.text = "Цена с учетом пошлин: "  + str(price_w_tar)
	goods_on_local_m.text   = "Кол-во на локальном рынке: " + str(local_market_quantity)
	


func get_m_price(supply, demand):
	if supply != 0:
		var border_price = (demand / supply) * good.base_price
		return border_price
	return 0


func spawn_buttons(market, container):
	for i in market:
		var button = container.get_node("Button").duplicate()
		button.good = i
		button.visible = true
		button.start(self)
		
		container.add_child(button)
