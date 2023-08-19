extends Panel

@onready var game = get_parent().get_parent().get_parent()
@onready var player = get_parent().get_parent()
@onready var start_research_button = $StartResearch
@onready var effects_container = $Effects
@onready var example_button = $TextureButtonExample
@onready var example_label  = $LabelExample

@onready var cotegories: Dictionary = {
	$HBoxContainer/ArmyManagerement: "army_managerment",
	$HBoxContainer/HeavyWeapon:      "heavy_weapon",
	$HBoxContainer/LightWeapon:      "light_weapon",
	$HBoxContainer/ShipDesign:       "ship_design",
	$HBoxContainer/FleetManagement:  "fleet_management",
	
	$HBoxContainer2/FactoryProduction:   "factory_production",
	$HBoxContainer2/FarmProduction:      "physics_and_energy",
	$HBoxContainer2/Metallurgy:          "metallurgy",
	$HBoxContainer2/Infrastructure:      "infrastructure",
	$HBoxContainer2/EconomicStructures:  "economic_structures",
}


var showing_technology: Technology


func _ready():
	update_technologies()


func update_technologies():
	for i in cotegories:
		var list = Players.get_player_client().research_manager.get(cotegories[i])

		for technology in list:
			spawn_button(list, i, technology)


func spawn_button(list, i, technology):
	var button = example_button.duplicate()
	button.parent = self
	button.technology = technology
	button.level = list.find(technology) + 1
	button.text = set_button_text(tr(technology.name_of_technology))
	i.add_child(button)


func set_button_text(text: String):
	if text.length() > 30:
		text = text.substr(0, 25)
		var new_text = text + "..."
		return new_text
	return text


func show_technology(button):
	clear_labels()
	show_technology_name(button.technology)
	
	for i in button.technology.list_of_effects:
		var label = example_label.duplicate()
		label.text = i.get_effect()
		effects_container.add_child(label)
	showing_technology = button.technology
	check_start_research_button()


func show_technology_name(technology):
	var label_name = example_label.duplicate()
	label_name.text = technology.name_of_technology
	effects_container.add_child(label_name)


func check_start_research_button():
	if Players.get_player_client().research_manager.researching_technology == null and showing_technology.ready_for_researching:
		start_research_button.disabled = false
	else:
		start_research_button.disabled = true


func clear_labels():
	for i in effects_container.get_children():
		i.queue_free()


func start_research():
	Players.get_player_client().research_manager.start_research(showing_technology)
	check_start_research_button()


