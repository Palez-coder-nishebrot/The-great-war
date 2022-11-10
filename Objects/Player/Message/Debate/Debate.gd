extends Panel

var client: Object

func _ready():
	rect_position = Vector2(436, 300)


func show_info(client):
	self.client = client
	

func button_pressed(ideology):
	get_party_with_best_support().popularity -= 5
	
	for i in client.parties_manager.list_of_parties:
		if i.ideology == ideology:
			i.popularity += 5
			break
	queue_free()


func get_party_with_best_support():
	var party = client.parties_manager.list_of_parties[0]
	for i in client.parties_manager.list_of_parties:
		if i.popularity > party.popularity:
			party = i
	return party
