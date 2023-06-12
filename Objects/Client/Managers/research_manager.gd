extends Node

class_name ResearchManager

signal research_completed

const MILITARY_TECHNOLOGIES_FILES: Array = [
	"army_managerment",
	"heavy_weapon",
	"light_weapon",
	"ship_design",
	]

const ECONOMIC_TECHNOLOGIES_FILES: Array = [
	"physics_and_energy",
	"metallurgy",
	"factory_production",
	"infrastructure",
	"economic_structures",
]


var army_managerment: Array = [
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/01.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/02.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/03.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/04.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/05.tres").duplicate(),
]


var heavy_weapon:     Array = [
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/01.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/02.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/03.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/04.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/05.tres").duplicate(),
]


var light_weapon:     Array = [
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/01.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/02.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/03.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/04.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/05.tres").duplicate(),
]

var ship_design:       Array = [
	load("res://Resources/Technologies/MilitaryTechnologies/ShipDesign/01.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/ShipDesign/02.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/ShipDesign/03.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/ShipDesign/04.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/ShipDesign/05.tres").duplicate(),
]

var fleet_management: Array = [
	load("res://Resources/Technologies/MilitaryTechnologies/FleetManagement/01.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/FleetManagement/02.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/FleetManagement/03.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/FleetManagement/04.tres").duplicate(),
	load("res://Resources/Technologies/MilitaryTechnologies/FleetManagement/05.tres").duplicate(),
]


var physics_and_energy:    Array = [
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/01.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/02.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/03.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/04.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/05.tres").duplicate(),
]


var metallurgy:         Array = [
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/01.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/02.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/03.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/04.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/Metallurgy/05.tres").duplicate(),
]


var factory_production: Array = [
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/01.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/02.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/03.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/04.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/05.tres").duplicate(),
]


var infrastructure:             Array = [
	load("res://Resources/Technologies/EconomyTechnologies/Infrastructure/01.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/Infrastructure/02.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/Infrastructure/03.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/Infrastructure/04.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/Infrastructure/05.tres").duplicate(),
]
var economic_structures: Array = [
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/01.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/02.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/03.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/04.tres").duplicate(),
	load("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/05.tres").duplicate(),
]


var researching_technology: Technology
var client: Object

var research_time: int = 0
var researching_points: float = 0


func _init():
	set_technologies()


func set_technologies():
	set_cotegories(MILITARY_TECHNOLOGIES_FILES)
	set_cotegories(ECONOMIC_TECHNOLOGIES_FILES)


func set_cotegories(TECHNOLOGIES_FILES):
	for i in TECHNOLOGIES_FILES:
		get(i)[0].ready_for_researching = true


func start_research(technology):
	pass


func finish_research():
	#activate_effects(effects_list)
	emit_signal("research_completed")


func activate_effects(effects_list):
	pass
