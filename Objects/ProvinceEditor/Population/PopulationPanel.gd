extends Panel


func update_information():
	clear_list()
	spawn_buttons()


func clear_list():
	for i in $VBoxContainer.get_children():
		i.queue_free()
			

func spawn_buttons():
	for i in get_parent().province.list_of_households:
		var button = load("res://Objects/ProvinceEditor/Population/HouseholdButton.tscn").instance()
		
		button.household = i
		$VBoxContainer.add_child(button)
		

func append_household():
	var province = get_parent().province
	
	if province.list_of_households.size() == 5: return
	var household = {
		education = false,
		ideology = "Популисты",
		soc_class = "Рабочий",
		religion = "",
	}
	
	province.list_of_households.append(household)
	
	if get_parent().province_editor.list_of_household_of_provinces.has(province.name_of_tile):
		get_parent().province_editor.list_of_household_of_provinces[province.name_of_tile].append(household)
	
	else:
		get_parent().province_editor.list_of_household_of_provinces[province.name_of_tile] = [household]
	update_information()
	

func erase_household(household):
	var province = get_parent().province
	
	province.list_of_households.erase(household)
	get_parent().province_editor.list_of_household_of_provinces[province.name_of_tile].erase(household)
	
	update_information()
