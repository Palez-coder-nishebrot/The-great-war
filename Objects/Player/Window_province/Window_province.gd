extends Panel

var province: Object

func update_information(province_, tipe):
	lock_or_open_buttons(false)
	show_info_about_province(province_)
	if province_.player == Players.player:
		$VBoxContainer/Railways.text =       "Железные дороги: " + str(province.railways.level)
		$VBoxContainer/Infrastructure.text = "Инфраструктура: "  + str(province.infrastructure.level)
		
		if tipe == "village":
			$VBoxContainer/Button.disabled  = true
			$VBoxContainer/Button4.disabled = true

	else:
		lock_or_open_buttons(true)
		

func show_info_about_province(province_):
	visible = true
	province = province_
	show_resourses()
	$VBoxContainer/Name.text =    province.name_of_tile
	$VBoxContainer/Country.text = province.player.name_of_country


func lock_or_open_buttons(bool_):
	$VBoxContainer/Button.disabled  = bool_
	$VBoxContainer/Button2.disabled = bool_
	$VBoxContainer/Button3.disabled = bool_
	$VBoxContainer/Railways.visible =       not bool_
	$VBoxContainer/Infrastructure.visible = not bool_


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


func train_army():
	Players.player.window_train_army.update_information(province)
