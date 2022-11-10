extends Node

class_name PoliticalParty

var list_of_values: Array = [
	"economic_policy",
	"trade_policy",
	"foreign_policy",
]

var client

var popularity: int = 0

var name_of_party: String      = ""
var ideology:      String      = ""

var form_of_government: String = ""
var economic_policy:    String = ""
var trade_policy:       String = ""
var foreign_policy:     String = ""

var cost_of_factories:      int = 0
var cost_of_infrastructure: int = 0

var elections:           bool   = false
var subsidization:       bool   = false
var income_of_capitalists: int   = 0
var max_tariffs:       int   = 0
var min_tariffs:       int   = 0

var supporting_soc_reforms: int = 0
var supporting_pol_reforms: int = 0


func set_party(ideology):
	var economy     = ideology.economic_policy
	var trade       = ideology.trade_policy
	var foreign     = ideology.foreign_policy
	var form_of_gov = ideology.form_of_government
	
	name_of_party = ideology.names_of_parties[0]
	self.ideology = ideology.ideology
	form_of_government = form_of_gov.name_of_policy
	
	economic_policy = economy.name_of_policy
	trade_policy    = trade.name_of_policy
	foreign_policy  = foreign.name_of_policy
	
	cost_of_factories      = economy.cost_of_factories
	cost_of_infrastructure = economy.cost_of_infrastructure
	
	elections = form_of_gov.elections
	subsidization = economy.subsidization
	income_of_capitalists = economy.income_of_capitalists
	max_tariffs = trade.max_tariffs
	min_tariffs = trade.min_tariffs
	
	supporting_soc_reforms = ideology.supporting_soc_reforms
	supporting_pol_reforms = ideology.supporting_pol_reforms
	

func change_country():
	client.economic_policy = economic_policy
	client.trade_policy = trade_policy
	client.foreign_policy = foreign_policy
	
	client.cost_of_factories      = cost_of_factories
	client.cost_of_infrastructure = cost_of_infrastructure
	client.subsidization          = subsidization
	client.income_of_capitalists   = income_of_capitalists
	client.max_tariffs            = max_tariffs
	client.min_tariffs            = min_tariffs
	check_subsidization()

func check_subsidization():
	if subsidization == false:
		for i in client.list_of_tiles:
			for y in i.list_of_buildings:
				if y.tipe == "factory":
					y.subsidization = false
