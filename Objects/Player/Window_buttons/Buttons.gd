extends Panel

const form_of_goverment_sprite: Dictionary = {
	"liberals": "res://Graphics/Sprites/GUI/Icons of windows/03.png",
	"socialists":"res://Graphics/Sprites/GUI/Icons of windows/01.png",
	"communists":"res://Graphics/Sprites/GUI/Icons of windows/02.png",
	"fascists":"res://Graphics/Sprites/GUI/Icons of windows/05.png",
	"conservators": "res://Graphics/Sprites/GUI/Icons of windows/04.png",
}


var windows: Array = [
	"window_build_factory",
	"window_production",
	"window_markets",
	"window_taxes",
	"window_reform",
	"window_parties",
	"window_parties",
	"window_population",
	"window_research",
	"window_diplomacy",
]

onready var education_label: Label = $VBoxContainer/EducationLabel/Label
onready var construction_label: Label = $VBoxContainer/ConstructionLabel/Label
onready var factory_label: Label = $VBoxContainer/FactoriesLabel/Label
onready var budget_label: Label = $VBoxContainer/BudgetLabel/Label
onready var research_label: Label = $VBoxContainer/ResearchLabel/Label
onready var ideology_label: Object = $VBoxContainer/PartiesLabel
onready var population_label: Label = $VBoxContainer/PopulationLabel/Label
onready var stability_label: Label = $VBoxContainer/StabilityLabel/Label
onready var unemployed_label: Label = $VBoxContainer/UnemployedLabel/Label
onready var reform_icon: TextureRect = $VBoxContainer/ReformIcon

#
#func _ready():
#	construction_label.add_image(load("res://Graphics/Sprites/GUI/Icons of windows/01.png"), 20, 20)

func on_button_pressed(window):
	
	var player = Players.player
	var b_window = player.get(window)
	
	#if window == "window_production":
		
	
	for i in windows:
		var v_window = player.get(i)
		if v_window != b_window:
			v_window.visible = false
	
	b_window.visible = not b_window.visible


func update_information():
	check_reform()
	education_label.text = str(Players.player.middle_value_education) + "%"
	factory_label.text = str(Players.player.list_of_factories.size())
	budget_label.text = str(Players.player.budget)
	stability_label.text = str(Players.player.stability)
	research_label.text = str(Players.player.growth_of_researching_points)
	
	
	ideology_label.get_node("TextureRect").texture = load(form_of_goverment_sprite[Players.player.ideology])
	ideology_label.get_node("Label").text = Players.player.ideology
	
	population_label.text = str(Players.player.welfare)
#	stability_label.text = str(Players.player.policy["Стабильность"])
	unemployed_label.text = str(Players.player.quantity_of_unemployed)


func check_reform():
	if Players.player.reforms_manager.social_reform or Players.player.reforms_manager.political_reform:
		reform_icon.visible = true
	else:
		reform_icon.visible = false
	
	pass
