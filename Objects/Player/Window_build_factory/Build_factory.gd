extends Panel

onready var player = get_parent().get_parent()

#var province: Object
var factory:  String
var cost: int
var choose_position_for_building: bool = false


func _visible():
	choose_position_for_building = false
	set_normal_color_of_province()
	clear()
	for i in player.economic_bonuses.list_of_buildings:
		var button = load("res://Objects/Player/Window_build_factory/Button_factory.tscn").instance()
		button.text = i
		button.parent = self
		#button.cost = Players.buildings_on_start[i]
		$ScrollContainer/VBoxContainer.add_child(button)


func check_building_limit(province):
	if province.max_of_buildings == province.list_of_buildings.size():
		return false
	else: 
		return true


func check_factory(name_of_factory):
	factory = name_of_factory
	
	check_purchase_for_construction($VBoxContainer/Label2,  Players.player.economic_bonuses.cost_of_factory,
	"Сырье для строительства")
	check_purchase_for_production(name_of_factory)
	
	$VBoxContainer/Label.text = name_of_factory
	
	choose_position_for_building = true
	set_color_of_province()


func check_purchase_for_construction(label, resources, first_text):
	label.text = first_text + "\n"
	for i in resources:
		if i == "Кроны":
			var cost_of_factory = resources[i] + (float(resources[i]) / 100.0 * player.economy["Цена_на_фабрики"])
			label.text += i + ": " + str(cost_of_factory)
			cost = cost_of_factory
		else:
			label.text += i + ": " + str(resources[i])
		if resources.keys().find(i) + 1 != resources.keys().size():
			label.text += "\n"


func check_purchase_for_production(name_of_factory):
	if not Players.not_factories.has(name_of_factory):
		check_purchase_for_construction($VBoxContainer/Label3, GlobalMarket.goods[GlobalMarket.find_building_in_list(name_of_factory)],
		"Сырье для производства")
	else:
		$VBoxContainer/Label3.text = "Сырье для производства" + "\n" + "Исключение"


func check_cost_of_factory():
	if player.budget >= cost:
		return true
	else:
		return false


func check_factory_in_province(province):
	var list = province.get_factories_in_province()
	return not list.has(factory)


func clear():
	for i in $ScrollContainer/VBoxContainer.get_children():
		i.queue_free()


func build_factory(province):
	if check_building_limit(province) and check_cost_of_factory() and check_factory_in_province(province):
		if factory != "Морской_завод":
			if factory != "Военный_завод":
				province.build_building(factory, cost)
			else:
				province.build_military_factory(factory, cost)
		
		check_factory(factory)
	
	
func set_color_of_province():
	for i in player.list_of_tiles:
		if not check_factory_in_province(i):
			i.modulate = Color(0, 0.45098, 0.74902)
		elif check_building_limit(i) and check_cost_of_factory():
			i.modulate = Color(0.854902, 0.219608, 0.219608)
		else:
			i.modulate = Color.gray


func set_normal_color_of_province():
	for i in player.list_of_tiles:
		i.modulate = i.player.national_color


func exit():
	visible = false
