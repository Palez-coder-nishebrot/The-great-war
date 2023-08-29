extends Panel

var province: Object

@onready var button_resources_container   = $HBoxContainer
@onready var button_region_chars_container = $VBoxContainer


func update_information(province_):
	lock_or_open_buttons(false)
	show_info_about_province(province_)
	if province_.player == Players.get_player_client():
		$VBoxContainer/Railways.text =       "Железные дороги: " + str(province.railways.level)

	else:
		lock_or_open_buttons(true)
		

func show_info_about_province(province_):
	visible = true
	province = province_
	show_resourses()
	$Name.text =    province.name_of_tile
	$Country.text = province.player.name_of_country
	$VBoxContainer/GrowthPopulation.text = "Прирост населения: +" + "Кирилл, доделай!"
	show_info_about_education_population()
	

func show_info_about_education_population():
	$VBoxContainer/EducationPopulation.text = "Фабричные рабочие: " + "Кирилл, доделай!"
	$VBoxContainer/EducationPopulation3.text = "Безработные: "  + "Кирилл, доделай!"


func lock_or_open_buttons(bool_):
	$VBoxContainer/Button2.disabled = bool_
	$VBoxContainer/Button3.disabled = bool_


func show_resourses():
	var DP_list = province.DP_list.duplicate()
	
	for i in button_resources_container.get_children():
		i.texture = load("res://Graphics/Sprites/goods/cross.png")
	
	for i in button_resources_container.get_children():
		if DP_list.size() > 0:
			var dp = DP_list[0]
			var good = dp.good
			i.texture = good.icon
			i.dp = dp
			DP_list.erase(dp)


func build_factory():
	Players.get_player().window_build_factory.show_self(province)


func exit():
	visible = false
