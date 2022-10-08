extends Panel

onready var game = get_parent().get_parent().get_parent()
onready var player = get_parent().get_parent()
onready var start_research_button = $StartResearch


onready var cotegories: Dictionary = {
	$HBoxContainer/ArmyManagerement: "army_managerment",
	$HBoxContainer/HeavyWeapon:      "heavy_weapon",
	$HBoxContainer/LightWeapon:      "light_weapon",
	$HBoxContainer/Navy:             "navy",
	
	$HBoxContainer2/FactoryProduction:   "factory_production",
	$HBoxContainer2/FarmProduction:      "farm_production",
	$HBoxContainer2/MinesProduction:     "mines_production",
	$HBoxContainer2/Supply:              "supply",
}


var showing_technology: Technology


func update_technologies():
	for i in cotegories:
		var list = player.technologies.get(cotegories[i])
		
		for technology in list:
			spawn_button(list, i, technology)


func spawn_button(list, i, technology):
	var button = $ButtonExample.duplicate()
	button.parent = self
	button.technology = technology
	button.level = list.find(technology) + 1
	button.text = technology.name_of_technology
	i.add_child(button)


func show_technology(button):
	clear_labels()
	for i in button.technology.list_of_effects:
		var label = $LabelExample.duplicate()
		label.text = i.get_effect()
		$Effects.add_child(label)
	showing_technology = button.technology
	check_start_research_button()


func check_start_research_button():
	if Players.player.technologies.researching_technology == null and showing_technology.ready_for_researching:
		start_research_button.disabled = false
	else:
		start_research_button.disabled = true


func clear_labels():
	for i in $Effects.get_children():
		i.queue_free()


func start_research():
	Players.player.technologies.start_research(showing_technology)
	check_start_research_button()
