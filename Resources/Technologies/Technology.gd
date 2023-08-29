extends Resource

class_name Technology

@export var cost: int = 1000
@export var activation_year: int = 1914

@export var name_of_technology: String = ""
var         cotegory:           String = ""

@export var list_of_effects: Array[TechnologyEffect] = []


func activate_effects(client):
	for i in list_of_effects:
		i.activate_effects(client)
