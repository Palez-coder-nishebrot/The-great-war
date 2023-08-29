extends Node

class_name ReformsManager


const REFORM_LIST: Array = [
	"school_system",
	"pensions",
	"min_wage",
	"working_hours",
	"unemployment_benefit",
	"healthcare",
	
#	"mass_media",
#	"political_parties",
#	"public_meetings",
#	"unions",
]


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

var government: Government = Government.new()

var client


func _init(client_):
	self.client = client_
	
	for i in REFORM_LIST:
		var reform_cot = get(i)
		reform_cot.connect("reform_is_carried", government.update_recharging_days)


func to_reform():
	
	pass


func roll_back_reform():
	pass


