extends Panel

var province: Object

func update_information(province_):
	if province_.player == Players.player:
		visible = true
		province = province_
		show_resourses()
		$VBoxContainer/Name.text =           province.name_of_tile
		$VBoxContainer/Country.text =        province.player.name_of_country
		$VBoxContainer/Railways.text =       "Железные дороги: " + str(province.railways.level)
		$VBoxContainer/Infrastructure.text = "Инфраструктура: "  + str(province.infrastructure.level)


func show_resourses():
	$VBoxContainer/Resourses.text = ""
	var token = 1
	for i in province.resources:
		
		if token != province.resources.size():
			$VBoxContainer/Resourses.text += i + ": " + str(province.resources[i]) + "\n"
		else:
			$VBoxContainer/Resourses.text += i + ": " + str(province.resources[i])
		token += 1


func exit():
	visible = false


func build_factory():
	Players.player.window_build_factory.province = province
	Players.player.window_build_factory.visible  = true
