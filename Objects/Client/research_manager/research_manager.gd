extends Node

class_name ResearchManager

signal research_completed

const BASIC_RESEARCHING_POINTS: float = 10.0

var accounting_value_getter: Callable

var army_managerment:    TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/ArmyManagerement/")
var heavy_weapon:        TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/HeavyWeapon/")
var light_weapon:        TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/LightWeapon/")
var ship_design:         TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/ShipDesign/")
var fleet_management:    TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/MilitaryTechnologies/FleetManagement/")
var physics_and_energy:  TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/PhysicsAndEnergy/")
var metallurgy:          TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/Metallurgy/")
var factory_production:  TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/FactoryProduction/")
var infrastructure:      TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/Infrastructure/")
var state_intervention:  TechnologyBranch = TechnologyBranch.new("res://Resources/Technologies/EconomyTechnologies/StateIntervention/")

var researching_technology_branch: TechnologyBranch
var researching_technology: Technology
var client: Object

var researching_points_growth:   float = 0.0

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
	set_researching_points()
	
	if researching_technology != null:
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


func set_researching_points():
	var pop_literacy          = accounting_value_getter.call("population_literacy")
	researching_points_growth = BASIC_RESEARCHING_POINTS + pop_literacy
	
#	if pop_literacy < 11 and pop_literacy > 0:
#		pass
#
#	if pop_literacy < 21 and pop_literacy > 10:
#		pass
#
#	if pop_literacy < 31 and pop_literacy > 20:
#		pass
#
#	if pop_literacy < 41 and pop_literacy > 30:
#		pass
#
#	if pop_literacy < 51 and pop_literacy > 40:
#		pass
#
#	if pop_literacy < 61 and pop_literacy > 50:
#		pass
#
#	if pop_literacy < 71 and pop_literacy > 60:
#		pass
#
#	if pop_literacy < 81 and pop_literacy > 70:
#		pass
#
#	if pop_literacy < 91 and pop_literacy > 80:
#		pass
#
#	if pop_literacy < 101 and pop_literacy > 90:
#		pass
