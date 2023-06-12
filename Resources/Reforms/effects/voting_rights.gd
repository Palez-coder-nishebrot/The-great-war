extends ReformEffect

class_name ReformEffectVotingRights

@export var effect_name: String = "voting_rights"

@export var rich_classes_votes: float   = 0.0
@export var middle_classes_votes: float = 0.0
@export var poor_classes_votes: float   = 0.0


func _init():
	target = "voting_rights"


func activate_effects(client):
	client.rich_classes_votes   += rich_classes_votes
	client.middle_classes_votes += middle_classes_votes
	client.poor_classes_votes   += poor_classes_votes


func deactivate_effects(client):
	client.rich_classes_votes   -= rich_classes_votes
	client.middle_classes_votes -= middle_classes_votes
	client.poor_classes_votes   -= poor_classes_votes
