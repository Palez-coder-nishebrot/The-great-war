extends RefCounted


class_name PartiesSupporter


var parties_supports: Dictionary = {
	load("res://Resources/Parties/Ideologies/Communists.tres"):   2.0,
	load("res://Resources/Parties/Ideologies/Conservators.tres"): 55.0,
	load("res://Resources/Parties/Ideologies/Fascists.tres"):     0.0,
	load("res://Resources/Parties/Ideologies/Liberals.tres"):     15.0,
	load("res://Resources/Parties/Ideologies/Libertarians.tres"): 2.0,
	load("res://Resources/Parties/Ideologies/Socialists.tres"):   26.0,
}


func add_support(ideology, num):
	ideology = get_ide_name(ideology)
	var num_1 = num / parties_supports.size()
	parties_supports[ideology] += num
	
	for i in parties_supports:
		if ideology != i:
			parties_supports[i] -= num_1


func get_majority():
	var ide = load("res://Resources/Parties/Ideologies/Communists.tres")
	for i in parties_supports:
		if parties_supports[i] > parties_supports[ide]:
			ide = i
	#print(ide == load("res://Resources/Parties/Ideologies/Conservators.tres"))
	return ide


func conservators_is_majority():
	if get_majority() == load("res://Resources/Parties/Ideologies/Conservators.tres"):
		return true
	return false


func majority_agree_with_ruling_party(ruling_party):
	if get_ide_name(ruling_party.ideology) == get_majority():
		return true
	return false


func government_form_is_republic(government_form):
	if government_form == load("res://Resources/Parties/Policy/goverment_form/republic.tres"):
		return true
	return false


func get_ide_name(ide):
	return ide.ideology
