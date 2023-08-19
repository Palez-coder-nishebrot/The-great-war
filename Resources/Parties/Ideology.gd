extends Resource

class_name Ideology

@export var ideology: String = "liberals"

@export var economic_policy: Resource
@export var trade_policy:    Resource
@export var military_policy: Resource
@export var national_issue:  Resource

@export var names_of_parties = [] # (Array, String)
@export var available_for_setting_ruling_party = [] # формы правления при которых можно назначить партию с этой идеологией правящей # (Array, Resource)

@export var supporting_soc_reforms: int = 0
@export var supporting_pol_reforms: int = 0

@export var rollback_soc_reforms: int = 0
@export var rollback_pol_reforms: int = 0

@export var government_form: Resource

