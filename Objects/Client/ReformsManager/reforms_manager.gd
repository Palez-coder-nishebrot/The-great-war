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

var points_social_reforms:    float = 0.0
var points_political_reforms: float = 0.0

var avaliable:    bool = false
var political_reform: bool = false
var reforms:          bool = false

var school_system:        ReformCotegory = ReformCotegory.new(load("res://Resources/reforms/social_reforms/school_system.tres"))
var pensions:             ReformCotegory = ReformCotegory.new(load("res://Resources/reforms/social_reforms/pensions.tres"))
var min_wage:             ReformCotegory = ReformCotegory.new(load("res://Resources/reforms/social_reforms/min_wage.tres"))
var working_hours:        ReformCotegory = ReformCotegory.new(load("res://Resources/reforms/social_reforms/working_hours.tres"))
var unemployment_benefit: ReformCotegory = ReformCotegory.new(load("res://Resources/reforms/social_reforms/unemployment_benefit.tres"))
var healthcare:           ReformCotegory = ReformCotegory.new(load("res://Resources/reforms/social_reforms/healthcare.tres"))

var mass_media:           ReformCotegory
var political_parties:    ReformCotegory
var public_meetings:      ReformCotegory
var unions:               ReformCotegory

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


