extends Node

class_name PartiesManager

var list_of_parties: Array = []
var ruling_party: PoliticalParty
var client: Object

func set_parties(client):
	self.client = client
	var folder: Directory = Directory.new()
	folder.open("res://Resources/Parties/Ideologies/")
	folder.list_dir_begin(true, true)
	
	for i in range(5):
		var party = PoliticalParty.new()
		var path_of_file = "res://Resources/Parties/Ideologies/" + folder.get_next()
		var file = load(path_of_file)
		party.client = client
		party.set_party(file)
		
		if client.ideology == file.ideology:
			ruling_party = party
