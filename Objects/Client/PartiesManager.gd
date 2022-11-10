extends Node

class_name PartiesManager

var list_of_parties: Array = []
var ruling_party: PoliticalParty
var client: Object

const popularity_of_parties: Dictionary = {
	"liberals": 30,
	"socialists": 15,
	"libertarians": 5,
	"communists": 5, 
	"fascists": 0, 
	"conservators": 45,
}


func _init(client, ideology):
	self.client = client
	set_parties(ideology)


func set_parties(ideology):
	self.client = client
	var folder: Directory = Directory.new()
	folder.open("res://Resources/Parties/Ideologies/")
	folder.list_dir_begin(true, true)
	
	for i in range(6):
		var party = PoliticalParty.new()
		var path_of_file = "res://Resources/Parties/Ideologies/" + folder.get_next()
		var file = load(path_of_file)
		party.client = client
		party.set_party(file)
		party.popularity = popularity_of_parties[party.ideology]
		list_of_parties.append(party)
		
		if ideology == file.ideology:
			ruling_party = party
			party.change_country()
