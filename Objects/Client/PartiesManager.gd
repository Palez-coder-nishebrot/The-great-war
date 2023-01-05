extends Node

class_name PartiesManager

var list_of_parties: Array = []
var ruling_party: PoliticalParty
var supporting_party_by_client: PoliticalParty
var client: Object

const growth_of_popularity: float = 0.05

var popularity_of_parties: Dictionary = {
	"liberals": 30.0,
	"socialists": 15.0,
	"libertarians": 5.0,
	"communists": 5.0, 
	"fascists": 0.0, 
	"conservators": 45.0,
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
		list_of_parties.append(party)
		
		if ideology == file.ideology:
			ruling_party = party
			party.change_country()


func update_popularity_of_parties():
	update_popularity_of_parties_by_client()


func find_the_most_popular_party():
	var ide = "liberals"
	for i in popularity_of_parties:
		if popularity_of_parties[i] > popularity_of_parties[ide]:
			ide = i
	return ide
	

func update_popularity_of_parties_by_client():
	if supporting_party_by_client != null:
		var ide = supporting_party_by_client.ideology
		
		if ruling_party.ideology != ide and popularity_of_parties[ide] < 40.0:
			popularity_of_parties[ide] += 0.05
			popularity_of_parties[find_the_most_popular_party()] -= 0.05
