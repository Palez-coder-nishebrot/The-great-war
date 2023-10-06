extends Panel


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

@onready var money_icon:            HBoxContainer = $VBoxContainer/money_icon
@onready var gdp_icon:               HBoxContainer = $VBoxContainer/gdp_icon
@onready var unemployed_icon:        HBoxContainer = $VBoxContainer/unemployed_icon
@onready var research_points_icon:   HBoxContainer = $VBoxContainer/research_points_icon
@onready var ruling_party_icon:      HBoxContainer = $VBoxContainer/ruling_party_icon
@onready var reforms_icon:           HBoxContainer = $VBoxContainer/reforms_icon
@onready var literacy_icon:          HBoxContainer = $VBoxContainer/literacy_icon
@onready var population_growth_icon: HBoxContainer = $VBoxContainer/population_growth_icon
@onready var welfare_icon:           HBoxContainer = $VBoxContainer/welfare_icon

#
#func _ready():
#	construction_label.add_image(load("res://Graphics/Sprites/GUI/Icons of windows/01.png"), 20, 20)

func on_button_pressed(window):
	
	var player = Players.get_player()
	var b_window = player.get(window)
	
	#if window == "window_production":
		
	
	for i in windows:
		var v_window = player.get(i)
		if v_window != b_window:
			v_window.visible = false
	
	b_window.visible = not b_window.visible


func update_information():
	var client = Players.get_player_client()
	#var dp_list = client.economy_manager.DP_list
	
	check_reform()
	
	money_icon.set_data(client.economy_manager.budget)
	gdp_icon.set_data(client.accounting_manager.gdp)
	unemployed_icon.set_data(client.accounting_manager.unemployed_quantity)
	literacy_icon.set_data(client.accounting_manager.population_literacy)
	welfare_icon.set_data(client.accounting_manager.population_welfare)
	research_points_icon.set_data(client.research_manager.researching_points_growth)
	population_growth_icon.set_data(str(client.accounting_manager.population_growth) + "/week")
	#ruling_party_icon.set_data(client.political_manager.ruling_party.party_name)
	#ruling_party_icon.set_data(ruling_party.party_name, ruling_party.)
	


func check_reform():
#	if Players.player.reforms_manager.social_reform or Players.player.reforms_manager.political_reform:
#		reform_icon.visible = true
#	else:
#		reform_icon.visible = false
	
	pass
