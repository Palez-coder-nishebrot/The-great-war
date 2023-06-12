extends Node

class_name PoliticalManager

const SUPPORTING_GROWTH: float = 0.02
const STARTING_IDEOLOGIES_LIST: Array = [
	"res://Resources/Parties/Ideologies/Communists.tres",
	"res://Resources/Parties/Ideologies/Conservators.tres",
	"res://Resources/Parties/Ideologies/Fascists.tres",
	"res://Resources/Parties/Ideologies/Liberals.tres",
	"res://Resources/Parties/Ideologies/Libertarians.tres",
	"res://Resources/Parties/Ideologies/Socialists.tres",
]

var parties_list: Array = []
var available_ideologies_for_setting_ruling: Array = []
var ruling_party: Node
var supported_party_by_client: Node

var ideology:           Resource
var form_of_government: Resource
var economic_policy:     Resource
var trade_policy:       Resource
var military_policy:    Resource

var get_factories_list: Callable


func set_parties(starting_ideology):
	var folder: DirAccess = DirAccess.open("res://Resources/Parties/Ideologies/")
	var _err_ = folder.list_dir_begin() # TODOGODOT4 fill missing arguments https://github.com/godotengine/godot/pull/40547
	
	for i in STARTING_IDEOLOGIES_LIST:
		var ideology_ = load(i)
		var party = PoliticalParty.new(ideology_)
		parties_list.append(party)
		
		if starting_ideology.ideology == ideology_.ideology:
			set_ruling_party(party)


func set_government_form(government_form: Resource):
	form_of_government = government_form
	available_ideologies_for_setting_ruling.clear()
	
	for id in STARTING_IDEOLOGIES_LIST:
		var ide = load(id)
		
		if ide.available_for_setting_ruling_party.has(form_of_government):
			available_ideologies_for_setting_ruling.append(ide)


func set_ruling_party(party):
	economic_policy = party.economy_policy
	trade_policy    = party.trade_policy
	military_policy = party.military_policy
	ideology        = party.ideology
	ruling_party    = party


func check_subsidization(factories_list):
	if economic_policy.subsidization == false:
		for factory in factories_list:
			factory.subsidization = false


func update_supported_party(new_supported_party):
	supported_party_by_client = new_supported_party
	

func check_party_for_setting_ruling(c_party):
	return available_ideologies_for_setting_ruling.has(c_party.ideology) and c_party != ruling_party
		
