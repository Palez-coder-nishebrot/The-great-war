extends Control

signal update_info(list)

var province
var factory: Object
var list_of_military_goods: Array = GlobalMarket.quanity_of_military_goods.keys()

func update_information():
	if not is_instance_valid(factory):
		get_parent().list_of_factories.erase(factory)
		queue_free()
	elif factory.in_construction == false:
		update()
	else:
		update_information_about_factory_in_construction()


func update_information_about_factory_in_construction():
	show_good()
	$Name_of_province.text = province.name_of_tile + "(" + str(province.list_of_households.size()) + ")"
	$Output.text = str(factory.time_of_construction) + "/" + str(factory.time)


func update():
	$Name_of_province.disabled = false
	if factory.closed == false:
		update_information_about_factory()
		
		if factory.tipe == "factory":
			update_information_about_income()
		else:
			$Income.text = ""
	
	else:
		update_information_about_closed_factory()


func update_information_about_income():
	var profit = factory.income - (factory.expenses_purchase + factory.expenses_workers)
	if profit >= 0: 
		$Income.text = "+" + str(profit)
		$Income.add_color_override("font_color", Color(0.094118, 0.580392, 0))
	else: 
		$Income.text = str(profit)
		$Income.add_color_override("font_color", Color(0.712891, 0.146894, 0.146894))


func update_information_about_factory():
	show_good()
	$Name_of_province.text = province.name_of_tile + "(" + str(province.list_of_households.size()) + ")"
	$Output.text = str(factory.output)
	$Workers.text = str(factory.quantity_of_workers) + "/" + str(factory.max_employed_number)
	$Bonus_for_production.text = "+" + "?" + "%"
	$Actions.update_information()


func update_information_about_closed_factory():
	$Name_of_province.text = province.name_of_tile + "(" + str(province.list_of_households.size()) + ")"
	$Output.text = "-"
	$Workers.text = "0/" + str(factory.max_employed_number)
	$Bonus_for_production.text = "+" + "?" + "%"
	$Name_of_province.disabled = true
	$Income.text = ""
	

func show_purchase():
	var list: Array = factory.purchase.keys()
	for i in $HBoxContainer.get_children():
		if not list.empty():
			i.icon = load(Players.sprites_of_goods[list[0]])
			list.erase(list[0])
	

func show_good():
	$Good.texture = load(Players.sprites_of_goods[factory.good])
	

func on_good_button_pressed(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == BUTTON_LEFT:
			if factory.tipe == "military_factory":
				var token = list_of_military_goods.find(factory.good) + 1
				if token == list_of_military_goods.size():
					token = 0
				factory.good = list_of_military_goods[token]
				factory.purchase = GlobalMarket.goods[list_of_military_goods[token]]
				show_purchase()
				show_good()
			
		elif event.button_index == BUTTON_RIGHT:
			var player = Players.player.window_production.info_about_factory_window
			player.factory = factory
			player.visible = true
			player.update_information()

