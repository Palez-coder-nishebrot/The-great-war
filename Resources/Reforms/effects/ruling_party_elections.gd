extends ReformEffect

class_name ReformEffectRulingPartyElections

@export var available: bool = true

@export var effect_name: String = "ruling_party_elections"

func _init():
	target = "ruling_party_elections"


func activate_effects(client):
	client.ruling_party_elections = available


func deactivate_effects(client):
	client.ruling_party_elections = not available
