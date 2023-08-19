extends Resource

class_name Technology

@export var cost: int = 1000
@export var activation_year: int = 1914

@export var name_of_technology: String = ""
var                cotegory           = ""

@export var list_of_effects: Array[TechnologyEffect] = []

var ready_for_researching: bool = false
