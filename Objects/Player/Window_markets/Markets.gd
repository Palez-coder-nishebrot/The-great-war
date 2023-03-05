extends Panel

signal update(market)

onready var good_label          = $VBoxContainer2/Label
onready var demand_label        = $VBoxContainer2/Label2
onready var supply_label        = $VBoxContainer2/Label3
onready var prices_label        = $VBoxContainer2/Label4
onready var warhouse_label      = $VBoxContainer2/Label5
onready var export_import_label = $VBoxContainer2/Label6


var good: Resource = load("res://Resources/Good/coal.tres")

func update_information():
	emit_signal("update")
	#emit_signal("update_info_about_output", Players.player.output)
	#emit_signal("update_info_about_warhouse", Players.player.warhouse_of_goods)
	
	update_information_about_good(good)


func update_information_about_good(new_good):
	good = new_good
	
	var player              = Players.player
	var demand_supply_good  = player.demand_supply_goods[good]
	var price               = player.prices_goods[good]
	var goods_warhouse      = player.warhouse_goods[good]
	var import_good         = player.import_goods[good]
	var export_good         = player.export_goods[good]
	
	good_label.text = good.name
	
	if import_good == 0:
		export_import_label.text = "Экспорт: " + str(export_good) 
	else:
		export_import_label.text = "Импорт: " + str(import_good)
	
	warhouse_label.text = "Гос. запасы: " + str(goods_warhouse)
	
	demand_label.text = "Спрос:"       + str(demand_supply_good[0])
	supply_label.text = "Предложение:" + str(demand_supply_good[1])
	
	prices_label.text = "Цена отечественном рынке:" + str(price)


func spawn_buttons(market, container):
	for i in market:
		var button = container.get_node("Button").duplicate()
		button.good = i
		button.visible = true
		button.start(self)
		
		container.add_child(button)
