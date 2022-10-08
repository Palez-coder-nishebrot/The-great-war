extends Panel

const form_of_goverment_sprite: Dictionary = {
	"liberals": "res://Graphics/Sprites/GUI/Icons of windows/03.png",
	"socialists":"res://Graphics/Sprites/GUI/Icons of windows/01.png",
	"communists":"res://Graphics/Sprites/GUI/Icons of windows/02.png",
	"fascists":"res://Graphics/Sprites/GUI/Icons of windows/05.png",
	"populists": "res://Graphics/Sprites/GUI/Icons of windows/04.png",
}

#onready var list_of_buttons: Dictionary = {
#	"Строительство":    "window_build_factory",
#	"Производство":     "window_production",
#	"Рынки":            "window_markets",
#	"Бюджет":           "window_taxes",
#	"Реформы":          "window_reform",
#	"Предпарламент":    "window_parties",
#	"Военные заказы":   "window_parties",
#	"Население":        "window_population",
#	"Технологии":       "window_research",
#	"Дипломатия":       "window_diplomacy",
#}

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

onready var budget_label: Button = $VBoxContainer/BudgetLabel
onready var research_label: Button = $VBoxContainer/ResearchLabel
onready var ideology_label: Button = $VBoxContainer/PartiesLabel
onready var population_label: Button = $VBoxContainer/PopulationLabel
onready var stability_label: Button = $VBoxContainer/StabilityLabel
onready var unemployed_label: Button = $VBoxContainer/UnemployedLabel
onready var pluralism_label: Button = $VBoxContainer/Pluralism
onready var radio_net_label: Button = $VBoxContainer/RadioNetLabel


func on_button_pressed(window):
	
	var player = Players.player
	var b_window = player.get(window)
	
	for i in windows:
		var v_window = player.get(i)
		if v_window != b_window:
			v_window.visible = false
	
	b_window.visible = not b_window.visible


func update_information():
	budget_label.text = str(Players.player.budget)
	research_label.text = str(Players.player.researching_points)
	
	ideology_label.icon = load(form_of_goverment_sprite[Players.player.ideology])
	ideology_label.text = Players.player.ideology
	
	population_label.text = str(Players.player.welfare)
#	stability_label.text = str(Players.player.policy["Стабильность"])
	unemployed_label.text = str(Players.player.quantity_of_unemployed)
	pluralism_label.text = str(Players.player.pluralism)
	radio_net_label.text = str(Players.player.radio_net)
