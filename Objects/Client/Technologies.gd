extends Node

class_name Technologies

const MILITARY_TECHNOLOGIES_FILES: Dictionary = {
	"army_managerment": "ArmyManagerement",
	"heavy_weapon":     "HeavyWeapon",
	"light_weapon":     "LightWeapon",
	"navy":             "Navy",
	}

const ECONOMIC_TECHNOLOGIES_FILES: Dictionary = {
	"physics_and_energy":    "PhysicsAndEnergy",
	"metallurgy":         "Metallurgy",
	"factory_production": "FactoryProduction",
	"supply":             "Supply",
	"economic_structures":"EconomicStructures"
}


var army_managerment: Array = [
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/01.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/02.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/03.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/04.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/05.tres"),
]


var heavy_weapon:     Array = [
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/01.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/02.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/03.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/04.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/05.tres"),
]


var light_weapon:     Array = [
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/01.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/02.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/03.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/04.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/05.tres"),
]


var navy:              Array = [
	load("res://Resources/Technologies/MilitaryTechnologies/Navy/01.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/Navy/02.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/Navy/03.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/Navy/04.tres"),
	load("res://Resources/Technologies/MilitaryTechnologies/Navy/05.tres"),
]


var physics_and_energy:    Array = [
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/01.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/02.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/03.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/04.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/05.tres"),
]


var metallurgy:         Array = [
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/01.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/02.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/03.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/04.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/05.tres"),
]


var factory_production: Array = [
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/01.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/02.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/03.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/04.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/05.tres"),
]


var supply:             Array = [
	load("res://Resources/Technologies/EconomyTechnologies/Supply/01.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/Supply/02.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/Supply/03.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/Supply/04.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/Supply/05.tres"),
]
var economic_structures: Array = [
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/01.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/02.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/03.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/04.tres"),
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/05.tres"),
]

var researching_technology: Technology
var client: Object

var research_time: int = 0


func _init(client_):
	self.client = client_
	
	set_technologies()


func set_technologies():
	set_cotegories(MILITARY_TECHNOLOGIES_FILES, "MilitaryTechnologies")
	set_cotegories(ECONOMIC_TECHNOLOGIES_FILES, "EconomyTechnologies")


func set_cotegories(TECHNOLOGIES_FILES, folder_name):
	for i in TECHNOLOGIES_FILES:
		get(i)[0].ready_for_researching = true


func start_research(technology):
	var pool_researching_points = technology.cost
	researching_technology = technology
	while pool_researching_points >= 0:
		yield(Players.player.game, "new_day")
		pool_researching_points -= client.researching_points
		client.researching_points = 0
	activate_effects()


func activate_effects():
	client.emit_signal("research_completed", researching_technology)
	
	for effect in researching_technology.list_of_effects:
		effect.activate_effects(client)
	update_ready_technology(researching_technology)
	
	researching_technology = null


func update_ready_technology(technology):
	var variable = get(technology.cotegory)
	var count = variable.find(technology)
	
	if count + 1 != variable.size():
		variable[count + 1].ready_for_researching = true
	technology.ready_for_researching = false
