extends ReformEffect

class_name ReformEffectParliamentaryElections

@export var available: bool = true

@export var effect_name: String = "parliamentary_elections"

func _init():
	target = "parliamentary_elections"


func activate_effects(client):
	client.parliamentary_elections = available


func deactivate_effects(client):
	client.parliamentary_elections = not available
