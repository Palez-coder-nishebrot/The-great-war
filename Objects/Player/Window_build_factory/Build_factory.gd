extends Panel

var province: Object
var factory:  String

func _visible():
	clear()
	check_building_limit()
	for i in Players.player.buildings:
		var button = load("res://Objects/Player/Window_build_factory/Button_factory.tscn").instance()
		button.text = i
		button.parent = self
		button.cost = Players.player.buildings[i]
		$ScrollContainer/VBoxContainer.add_child(button)


func check_building_limit():
	if province.max_of_buildings == province.list_of_buildings.size() + province.list_of_military_factories.size():
		$Button.disabled = true
		return true
	else: 
		$Button.disabled = false
		return false
		
		
func check_factory(name_of_factory):
	check_building_limit()
	$VBoxContainer/Label.text = name_of_factory
	factory = name_of_factory
	
	show_resources($VBoxContainer/Label2,  Players.player.buildings[name_of_factory],
	"Сырье для строительства:")
	
	if not Players.not_factories.has(name_of_factory):
		show_resources($VBoxContainer/Label3, GlobalMarket.goods[GlobalMarket.find_building_in_list(name_of_factory)],
		"Сырье для производства:")
	else:
		$VBoxContainer/Label3.text = "Сырье для производства:" + "\n" + "Исключение"


func show_resources(label, resources, first_text):
	label.text = first_text + "\n"
	for i in resources:
		label.text += i + ": " + str(resources[i]) + "\n"


func clear():
	for i in $ScrollContainer/VBoxContainer.get_children():
		i.queue_free()


func start_build():
	if check_building_limit() == true:
		if factory != "Военный_завод":
			province.build_building(factory)
		else:
			province.build_military_factory(factory)


func exit():
	visible = false
