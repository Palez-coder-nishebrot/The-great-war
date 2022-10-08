extends Panel

var population_manager

onready var household_label = $VBoxContainer/Household
onready var workers_label = $VBoxContainer/Workers
onready var factory_workers_label = $VBoxContainer/FactoryWorkers
onready var craftsmen_label = $VBoxContainer/HBoxContainer/Craftsmen
onready var good_button = $VBoxContainer/HBoxContainer/Good


func update_information():
	if population_manager != null:
		household_label.text       = "Домохозяйство: "      + population_manager.province.name_of_tile
		workers_label.text         = "Рабочие: "           + str(population_manager.list_of_workers.size())
		factory_workers_label.text = "Фабричные рабочие: " + str(population_manager.list_of_factory_workers.size())
		craftsmen_label.text       = "Ремесленники: "      + str(population_manager.list_of_craftsmen.size())
		#for i in population_manager.list_of_craftsmen:
		#	print(i.soc_class)
		#print(population_manager.list_of_craftsmen)
		
		if population_manager.list_of_craftsmen.size() > 0:
			var good = population_manager.province.player.game.craftsmen_manager.good_for_production_by_craftsmen
			good_button.icon                  = load(Players.sprites_of_goods[good])
		else:
			good_button.icon                  = null
	

func exit():
	visible = false
