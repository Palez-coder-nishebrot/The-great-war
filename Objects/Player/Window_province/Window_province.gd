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
	$Name.text =    province.name_of_tile
	$Country.text = province.player.name_of_country


func lock_or_open_buttons(bool_):
	$VBoxContainer/Button.disabled  = bool_
	$VBoxContainer/Button2.disabled = bool_
	$VBoxContainer/Button3.disabled = bool_
	$VBoxContainer/Railways.visible =       not bool_
	$VBoxContainer/Infrastructure.visible = not bool_


func show_resourses():
	var res = province.resources.keys()
	for i in $HBoxContainer.get_children():
		i.icon = load("res://Graphics/Sprites/Goods/kREST.png")
	
	for i in $HBoxContainer.get_children():
		if res.size() > 0:
			i.icon = load(Players.sprites_of_goods[res[0]])
			res.erase(res[0])


func exit():
	visible = false


func build_factory():
	Players.player.window_build_factory.province = province
	Players.player.window_build_factory.visible  = true


func train_army():
	Players.player.window_train_army.update_information(province)
