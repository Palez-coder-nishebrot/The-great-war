extends Resource

class_name Ideology

@export var ideology: String = "liberals"

@export var economic_policy: EconomyIssue
@export var trade_policy:    TradeIssue
@export var military_policy: MilitaryIssue
@export var national_issue:  MigrationIssue

@export var names_of_parties: Array[String] = [] # (Array, String)
@export var available_for_setting_ruling_party: Array[GovernmentForm] = [] # формы правления при которых можно назначить партию с этой идеологией правящей # (Array, Resource)

@export var supporting_soc_reforms: int = 0
@export var supporting_pol_reforms: int = 0

@export var rollback_soc_reforms: int = 0
@export var rollback_pol_reforms: int = 0

@export var government_form: Resource
@export var ideology_icon:   Texture
