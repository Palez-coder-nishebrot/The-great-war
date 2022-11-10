extends Panel

var population_manager

onready var household_label = $VBoxContainer/Household
onready var workers_label = $VBoxContainer/Workers
onready var factory_workers_label = $VBoxContainer/FactoryWorkers
onready var clerks_label = $VBoxContainer/Clerks
onready var unemployed_label = $VBoxContainer/Unemployed

func update_information():
	if population_manager != null:
		household_label.text       = "Домохозяйство: "      + population_manager.province.name_of_tile
		workers_label.text         = "Рабочие: "           + str(population_manager.quantity_of_workers)
		factory_workers_label.text = "Фабричные рабочие: " + str(population_manager.quantity_of_factory_workers)
		clerks_label.text       = "Служащие: "      + str(population_manager.quantity_of_clerks)
		unemployed_label.text = "Безработные: "+ str(population_manager.quantity_of_unemployed)
		#for i in population_manager.list_of_craftsmen:
		#	print(i.soc_class)
		#print(population_manager.list_of_craftsmen)
	

func exit():
	visible = false
