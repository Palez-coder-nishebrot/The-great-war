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


var army_managerment:    TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/")
var heavy_weapon:        TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/")
var light_weapon:        TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/")
var ship_design:         TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/ShipDesign/")
var fleet_management:    TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/FleetManagement/")
var physics_and_energy:  TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/")
var metallurgy:          TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/Metallurgy/")
var factory_production:  TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/")
var infrastructure:      TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/Infrastructure/")
var economic_structures: TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/EconomicStructures/")


var researching_technology_branch: TechnologyBranch
var researching_technology: Technology
var client: Object


var remaining_days:              int   = 0
var researching_points:          float = 0.0
var required_researching_points: float = 0.0


func _init():
	SceneStorage.game.connect("new_day", Callable(self, "new_day"))


func start_research(technology_branch):
	print("research started")
	var technology = technology_branch.branch_levels[technology_branch.level + 1]
	researching_points = 0.0
	required_researching_points = technology.cost
	researching_technology = technology
	researching_technology_branch = technology_branch


func new_day():
	if researching_technology != null:
		var researching_points_growth = 100.0
		researching_points += researching_points_growth
		remaining_days = int((required_researching_points - researching_points) / researching_points_growth)
		if researching_points > required_researching_points:
			finish_research()


func finish_research():
	researching_technology_branch.level_up()
	researching_technology_branch = null
	researching_technology        = null
	print("research_completed")
	#activate_effects(effects_list)
	#emit_signal("research_completed")
	pass


func activate_effects(_effects_list):
	pass
