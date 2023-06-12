extends Control

signal update_info(list) # Сигнал вызывается! (наверно)

var province
var factory: Object

@onready var actions_container: VBoxContainer      = $Actions
@onready var raw_container: HBoxContainer          = $HBoxContainer
@onready var production_goods_label: Label = $Output
@onready var workers_label: Label          = $Workers
@onready var income_label: Label           = $Income
@onready var efficiency_label: Label       = $Efficiency
@onready var good_texture_rect: TextureRect      = $Good


func Che_za_huinya():
	actions_container      = $Actions
	raw_container          = $HBoxContainer
	production_goods_label = $Output
	workers_label          = $Workers
	income_label           = $Income
	efficiency_label       = $Efficiency
	good_texture_rect      = $Good


func update_information():
	if actions_container != null and income_label != null:
		if not is_instance_valid(factory):
			get_parent().list_of_factories.erase(factory)
			queue_free()
		elif factory.in_construction == false:
			update()
		else:
			update_information_about_factory_in_construction()


func update_information_about_factory_in_construction():
	show_good()
	production_goods_label.text = str(factory.time_of_construction) + "/" + str(factory.time)


func update():
	if factory.closed == false:
		update_information_about_factory()
		update_information_about_income()
	
	else:
		update_information_about_closed_factory()


func update_information_about_income():
	var profit = factory.get_profit()
	if profit >= 0: 
		income_label.text = "+" + str(profit)
		income_label.add_theme_color_override("font_color", Color(0.094118, 0.580392, 0))
	else: 
		income_label.text = str(profit)
		income_label.add_theme_color_override("font_color", Color(0.712891, 0.146894, 0.146894))


func update_information_about_factory():
	show_good()
	production_goods_label.text = str(factory.good_production)
	workers_label.text = str(factory.workers_quantity) + "/" + str(factory.real_max_employed_number)
	efficiency_label.text = "+" + str(factory.get_effiency_production()) + "%"
	actions_container.update_information()


func update_information_about_closed_factory():
	production_goods_label.text = "-"
	workers_label.text = "0/" + str(factory.max_employed_number)
	efficiency_label.text = "-"
	income_label.text = "-"
	

func show_purchase():
	Che_za_huinya()
	var list: Array = factory.raw_storage.duplicate()
	var children    = raw_container.get_children()
	
	for storage_good in list:
		var raw_icon = children[list.find(storage_good)]
		raw_icon.texture = storage_good.good.icon
		raw_icon.storage_good = storage_good
	

func show_good():
	good_texture_rect.texture = factory.good.icon
	

func on_good_button_pressed(event):
	if event is InputEventMouseButton and event.is_pressed():
		if event.button_index == MOUSE_BUTTON_RIGHT:
			var window = Players.player.window_production.info_about_factory_window
			window.factory = factory
			window.visible = true
			window.update_information()
