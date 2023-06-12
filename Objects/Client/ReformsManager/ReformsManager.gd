extends Node

class_name ReformsManager

const paths: Dictionary = {
#	"tax_on_poor_class": "res://Resources/Reforms/EconomicReforms/TaxOnPoorClass.tres",
#	"tax_on_rich_class": "res://Resources/Reforms/EconomicReforms/TaxOnRichClass.tres",
#	"tariffs":           "res://Resources/Reforms/EconomicReforms/Tarrifs.tres",
#	"education":         "res://Resources/Reforms/EconomicReforms/Education.tres",
#
#	"pensions":          "res://Resources/Reforms/SocialReforms/Pensions.tres",
#	"min_salary":        "res://Resources/Reforms/SocialReforms/MinSalary.tres",
#	"max_working_day":      "res://Resources/Reforms/SocialReforms/DayWorking.tres",
#	"unemployment_benefit": "res://Resources/Reforms/SocialReforms/UnemploymentBenefit.tres",
#	"healthcare":        "res://Resources/Reforms/SocialReforms/Healthcare.tres",
#	"mass_media":        "res://Resources/Reforms/PoliticalReforms/MassMedia.tres",
#	"political_parties": "res://Resources/Reforms/PoliticalReforms/PoliticalParties.tres",
#	"public_meentings":  "res://Resources/Reforms/PoliticalReforms/PublicMeetings.tres",
#	"unions":            "res://Resources/Reforms/PoliticalReforms/Unions.tres",
}

var max_points_of_soc_reforms: Dictionary = {
	"liberals":     80,
	"socialists":   50,
	"libertarians": 5000,
	"communists":   50, 
	"fascists":     50, 
	"conservators": 80,
}

var max_points_of_pol_reforms: Dictionary = {
	"liberals":     50,
	"socialists":   80,
	"libertarians": 50,
	"communists":   5000, 
	"fascists":     5000, 
	"conservators": 80,
}

var points_social_reforms:    float = 0.0
var points_political_reforms: float = 0.0

var social_reform:    bool = false
var political_reform: bool = false
var reforms:          bool = false

var tax_on_poor_class
var tax_on_rich_class
var tariffs
var education

var pensions
var min_salary
var max_working_day
var unemployment_benefit
var healthcare

var mass_media
var political_parties
var public_meentings
var unions

var client

func _init(client_):
	self.client = client_
	#set_cotegories()


func set_cotegories():
	for reform in paths:
		var path = paths[reform]
		var file = load(path)
		var cotegory = CotegoryReform.new()
		cotegory.effects = file.effects
		cotegory.activing_reform = cotegory.effects[0]
		set(reform, cotegory)


func reform_activeted(effect, cotegory):
	var cot = get(cotegory)
	
	#var num = client.get(cot.activing_reform.additional_target)
	client.set(cot.activing_reform.additional_target, -cot.activing_reform.additional_value)
	
	cot.activing_reform = effect

	client.set(cotegory, effect.value)
	
	#print()
	#print(client.get(cotegory))


func update_points_of_reforms():
	if client.parties_manager != null:
		var supporting_soc_reforms = 0
		var supporting_pol_reforms = 0
		var size_of_list = client.parties_manager.list_of_parties.size()
		for i in client.parties_manager.list_of_parties:
			supporting_soc_reforms += i.supporting_soc_reforms * client.parties_manager.popularity_of_parties[i.ideology]
			supporting_pol_reforms += i.supporting_pol_reforms * client.parties_manager.popularity_of_parties[i.ideology]
		
		supporting_soc_reforms = supporting_soc_reforms / size_of_list
		supporting_pol_reforms = supporting_pol_reforms / size_of_list
		#breakpoint
		points_political_reforms += (supporting_pol_reforms * 0.01) + (100 - client.stability)
		points_social_reforms    += (supporting_soc_reforms * 0.01) + (100 - client.stability)
		
		check_reforms()


func check_reforms():
	var ide = client.ideology
	var max_points_to_soc = max_points_of_soc_reforms[ide]
	var max_points_to_pol = max_points_of_pol_reforms[ide]
	
	if points_political_reforms >= max_points_to_pol:
		political_reform = true
		points_political_reforms = 0
		client.emit_signal("check_available_reform", "political_reform")
	
	if points_social_reforms >= max_points_to_soc:
		social_reform = true
		points_social_reforms = 0
		client.emit_signal("check_available_reform", "social_reform")


func check_data(data):
	if data.day == 1 and data.month == 1:
		reforms = true
		
	elif data.day == 1 and data.month == 6:
		reforms = true
