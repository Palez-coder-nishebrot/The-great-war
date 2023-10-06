extends Node

class_name PoliticalParty

var list_of_values: Array = [
	"economic_policy",
	"trade_policy",
	"foreign_policy",
]

var party_name: String      = ""

var ideology:           Resource
var form_of_government: Resource
var economy_policy:     Resource
var trade_policy:       Resource
var military_policy:    Resource
var national_issue:     Resource

var avaliable: bool = false


func _init(party_ideology):
	party_name         = party_ideology.names_of_parties[0]
	ideology           = party_ideology
	economy_policy     = party_ideology.economic_policy
	trade_policy       = party_ideology.trade_policy
	military_policy    = party_ideology.military_policy
	national_issue     = party_ideology.national_issue
	form_of_government = party_ideology.government_form


func check_subsidization(client):
	var subsidization = economy_policy.subsidization
	if subsidization == false:
		for i in client.list_of_tiles:
			for y in i.list_of_buildings:
				if y.tipe == "factory":
					y.subsidization = false


func get_party_name():
	return tr(party_name)


func get_economic_policy():
	return tr(economy_policy.policy_name)


func get_trade_policy():
	return tr(trade_policy.policy_name)


func get_military_policy():
	return tr(military_policy.policy_name)


func get_national_issue():
	return tr(national_issue.policy_name)


func get_ideology():
	return tr(ideology.ideology)


func get_government_form():
	return tr(form_of_government.policy_name)
