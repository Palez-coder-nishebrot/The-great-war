extends Panel

var province: Object

onready var button_resources_container   = $HBoxContainer
onready var button_region_chars_container = $VBoxContainer

func update_information(province_):
	lock_or_open_buttons(false)
	show_info_about_province(province_)
	if province_.player == Players.player:
		$VBoxContainer/Railways.text =       "Железные дороги: " + str(province.railways.level)

	else:
		lock_or_open_buttons(true)
		

func show_info_about_province(province_):
	visible = true
	province = province_
	show_resourses()
	$Name.text =    province.name_of_tile
	$Country.text = province.player.name_of_country
	$VBoxContainer/GrowthPopulation.text = "Прирост населения: +" + str(province.population_manager.growth_of_new_generation)
	show_info_about_education_population()
	

func show_info_about_education_population():
	var num = province.population_manager.quantity_of_factory_workers
	$VBoxContainer/EducationPopulation.text = "Фабричные рабочие: " + str(num)
	$VBoxContainer/EducationPopulation3.text = "Безработные: "  + str(province.population_manager.quantity_of_unemployed)


func lock_or_open_buttons(bool_):
	$VBoxContainer/Button2.disabled = bool_
	$VBoxContainer/Button3.disabled = bool_
	#$VBoxContainer/Railways.visible = not bool_


func show_resourses():
	var res = province.resources.duplicate()
	for i in button_resources_container.get_children():
		i.icon = load("res://Graphics/Sprites/Goods/kREST.png")
	
	for i in button_resources_container.get_children():
		if res.size() > 0:
			i.icon = res[0].icon
			res.erase(res[0])


func build_factory():
	Players.player.window_build_factory.region = province
	Players.player.window_build_factory.visible = true


func exit():
	visible = false
