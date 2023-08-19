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

var school_system:        Reform = load("res://Resources/reforms/social_reforms/school_system.tres")
var pensions:             Reform
var min_salary:           Reform
var max_working_day:      Reform
var unemployment_benefit: Reform
var healthcare:           Reform

var mass_media:           Reform
var political_parties:    Reform
var public_meetings:      Reform
var unions:               Reform

var client

func _init(client_):
	self.client = client_
	#set_cotegories()


func reform_activeted(effect, cotegory):
	var cot = get(cotegory)
	
	#var num = client.get(cot.activing_reform.additional_target)
	client.set(cot.activing_reform.additional_target, -cot.activing_reform.additional_value)
	
	cot.activing_reform = effect

	client.set(cotegory, effect.value)
	
	#print()
	#print(client.get(cotegory))


