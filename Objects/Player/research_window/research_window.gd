extends Panel

@onready var game = get_parent().get_parent().get_parent()
@onready var player = get_parent().get_parent()
@onready var start_research_button = $StartResearch
@onready var effects_container = $Effects
@onready var example_button  = $TextureButtonExample
@onready var example_label   = $LabelExample
@onready var tech_info_label = $Label

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

var showing_technology_branch: TechnologyBranch


func _ready():
	SceneStorage.game.connect("new_day", new_day)
	update_technologies()


func new_day():
	var client     = Players.get_player_client()
	
	if client.research_manager.researching_technology != null:
		var level      = showing_technology_branch.level
		var technology = showing_technology_branch.branch_levels[level + 1]
		tech_info_label.text = tr(technology.name_of_technology) + "\n"
		tech_info_label.text += "Осталось дней: " + str(client.research_manager.remaining_days)
	else:
		tech_info_label.text = ""


func update_technologies():
	for i in cotegories:
		var technology_branch = Players.get_player_client().research_manager.get(cotegories[i])
		var level = 0
		for technology in technology_branch.branch_levels:
			spawn_button(level, i, technology, technology_branch)
			level += 1


func spawn_button(level, container, technology, technology_branch):
	var button = example_button.duplicate()
	button.parent = self
	button.technology = technology
	button.level = level
	button.text = set_button_text(tr(technology.name_of_technology))
	button.technology_branch = technology_branch
	container.add_child(button)


func set_button_text(text: String):
	if text.length() > 25:
		text = text.substr(0, 22)
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
	showing_technology_branch = button.technology_branch
	check_start_research_button(button.level, button.technology_branch.level)


func show_technology_name(technology):
	var label_name = example_label.duplicate()
	label_name.text = technology.name_of_technology
	effects_container.add_child(label_name)


func check_start_research_button(technology_level, tech_branch_level):
	if Players.get_player_client().research_manager.researching_technology == null and technology_level == tech_branch_level + 1:
		start_research_button.disabled = false
	else:
		start_research_button.disabled = true


func clear_labels():
	for i in effects_container.get_children():
		i.queue_free()


func start_research():
	Players.get_player_client().research_manager.start_research(showing_technology_branch)
	start_research_button.disabled = true


