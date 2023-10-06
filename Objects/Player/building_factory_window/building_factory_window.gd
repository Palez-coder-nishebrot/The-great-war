extends Control

@onready var player            = get_parent().get_parent()
@onready var buttons_container = $ScrollContainer/VBoxContainer

@onready var build_button           = $build_button

@onready var factory_description = $factory_description

#var province: Object
var factory
var cost: int
var region: Object


#func _ready():
#	$Button.set_text


func show_self(province):
	visible = true
	region = province.get_parent()
	clear()
	set_factory_buttons()


func set_factory_buttons():
	for i in buttons_container.get_children():
		i.queue_free()
	var list = Players.get_player_client().economy_manager.avaliable_factories
	for i in list:
		var button = load("res://Objects/Player/building_factory_window/factory_button/Button_factory.tscn").instantiate()
		button.text = i.name_of_factory
		button.factory = i
		button.parent = self
		button.icon = i.good.icon
		buttons_container.add_child(button)


func clear():
	factory_description.text = ""


func check_building_limit(region):
	if region.max_of_buildings == region.factories_list.size():
		return false
	else: 
		return true


func show_factory_info(new_factory):
	clear()
	factory_description.text += region.region_name + "\n"
	factory = new_factory
	check_chars()
	

func check_chars():
	factory_description.text += tr(factory.name_of_factory) + "\n"
	factory_description.text += "Прибыль: "  + "\n"#+ str(Players.player.economic_bonuses.get_profit_of_factory(factory))
	check_purchase_for_production()


func check_purchase_for_production():
	var raw = factory.raw
	for i in raw:
		if not i is FactoryEquipment:
			factory_description.add_image(i.good.icon, 64, 64)
			factory_description.add_text(str(i.quantity) + " ")
	factory_description.add_text("\n")
	
	
func check_cost_of_factory():
	if player.budget >= cost:
		return true
	else:
		return false


func check_factory_in_province(province):
	var list = province.get_factories_in_province()
	return not list.has(factory)


func build_factory():
	region.build_factory(factory)


func close_window():
	visible = false
	clear()
