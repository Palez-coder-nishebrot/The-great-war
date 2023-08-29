extends Node

class_name Client

signal check_available_reform(tipe_of_reform) # Сигнал вызывается!
signal research_completed # Сигнал вызывается!

@export var state_on_start: StateOnStartGame

var population_units_list: Array = []
var regions_list:          Array = []

var economy_manager:            EconomyManager         = EconomyManager.new()
var political_manager:          PoliticalManager       = PoliticalManager.new(self)
var research_manager:           ResearchManager        = ResearchManager.new()
var accounting_manager:         AccountingManager      = AccountingManager.new(self)
var population_manager:         PopulationManager      = PopulationManager.new(self)
var reforms_manager:            ReformsManager         = ReformsManager.new(self)

var military_bonuses:         MilitaryBonuses        = MilitaryBonuses.new()

var state_on_starting:        StateOnStartGame

var name_of_country:         String    = ""
var path_to_file_of_country: String    = ""

var population: int = 0

var list_of_active_units: Array        = []
var list_of_projects:     Array        = [] #ПРОЕКТЫ (НЕДОДЕЛАНО)

var national_flag:       Sprite2D 
var national_color:      Color
@onready var game:       Node2D


func register_region(region):
	add_child(region)
	regions_list.append(region)
	population_units_list.append_array(region.population.population_types)


func erase_region(region):
	remove_child(region)
	regions_list.erase(region)
	
	for i in region.population.population_types:
		population_units_list.erase(i)


func get_education_cost():
	return economy_manager.education_cost


func get_pop_unit_for_migration(income: float, population_type: Resource):
	var count = population_type.index_in_pop_types_list
	for i in regions_list:
		var new_region_pop_unit = i.population.population_types[count]
		if new_region_pop_unit.income > income:
			return new_region_pop_unit
	return false


func get_population_units_list():
	return population_units_list


func get_regions_list():
	return regions_list


func update_values_of_population():
	pass


func get_ruling_party():
	return political_manager.ruling_party


func get_government_form():
	return political_manager.form_of_government#.policy_name
