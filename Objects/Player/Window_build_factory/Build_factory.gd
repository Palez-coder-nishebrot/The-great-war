extends Panel

onready var player            = get_parent().get_parent()
onready var buttons_container = $ScrollContainer/VBoxContainer

onready var name_region_label      = $VBoxContainer/Label5
onready var factory_name_label     = $VBoxContainer/Label
onready var construction_raw_label = $VBoxContainer/Label2
onready var production_raw_label   = $VBoxContainer/Label3
onready var factory_profit_label   = $VBoxContainer/Label4

#var province: Object
var factory:  Node
var cost: int
var region: Object

func _visible():
	name_region_label.text = region.name_of_tile
	clear()
	set_factory_buttons()


func set_factory_buttons():
	for i in player.economic_bonuses.list_of_buildings:
		var button = load("res://Objects/Player/Window_build_factory/Button_factory.tscn").instance()
		button.text = i.name_of_factory
		button.factory = i
		button.parent = self
		button.icon = i.good.icon
		buttons_container.add_child(button)


func clear():
	for i in buttons_container.get_children():
		i.queue_free()


func check_building_limit(province):
	if province.max_of_buildings == province.list_of_buildings.size():
		return false
	else: 
		return true


func show_factory_info(new_factory):
	factory = new_factory
	check_chars()
	

func check_chars():
	factory_name_label.text = factory.name_of_factory
	factory_profit_label.text = "Прибыль: " #+ str(Players.player.economic_bonuses.get_profit_of_factory(factory))
	production_raw_label.text = check_purchase_for_production()


func check_purchase_for_construction(label, resources, first_text):
	label.text = first_text + "\n"
	for i in resources:
		if i == "Кроны":
			var cost_of_factory = resources[i] + (float(resources[i]) / 100.0 * player.cost_of_factories)
			label.text += i + ": " + str(cost_of_factory)
			cost = cost_of_factory
		else:
			label.text += i + ": " + str(resources[i])
		if resources.keys().find(i) + 1 != resources.keys().size():
			label.text += "\n"


func check_purchase_for_production():
	var text = ""
	
	for raw in factory.raw:
		text += tr(raw.name) + ": " + str(factory.raw[raw]) + "\n"
	return text


func check_cost_of_factory():
	if player.budget >= cost:
		return true
	else:
		return false


func check_factory_in_province(province):
	var list = province.get_factories_in_province()
	return not list.has(factory)


func build_factory(province):
	var profit = player.economic_bonuses.get_profit_of_factory(factory)
	if check_building_limit(province) and check_cost_of_factory() and check_factory_in_province(province) and profit > 0:
		province.build_building(factory, cost)
		
		show_factory_info(factory)


func exit():
	visible = false
