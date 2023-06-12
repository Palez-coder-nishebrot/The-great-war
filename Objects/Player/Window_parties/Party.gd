extends Control

var party: Object
@onready var supporting_party_button: Object = $SupportParty
@onready var ruling_party_button: Object = $RulingParty

func update():
	if party != null:
		$NameOfParty.text   = party.get_party_name()
		$Ideology.text      = party.get_ideology()
		$Economy.text       = "Эк. политика: "      + party.get_economic_policy()
		$TradePolicy.text   = "Торговая политика: " + party.get_trade_policy()
		$ForeignPolicy.text = "Военная политика: "  + party.get_military_policy()
		update_ruling_party()
		check_party_supporting()
	else:
		breakpoint


func check_party_supporting():
	if Players.player.political_manager.supported_party_by_client == party:
		supporting_party_button.text = "Ведется поддержка партии"
	else:
		supporting_party_button.text = "Поддержать партию"


func update_ruling_party():
	if Players.player.political_manager.check_party_for_setting_ruling(party):
		ruling_party_button.disabled = false
	else:
		ruling_party_button.disabled = true


func set_ruling_party():
	Players.player.political_manager.set_ruling_party(party)
	update()


func update_supporting_party_by_client():
	Players.player.political_manager.update_supported_party(party)
	
	get_parent().get_parent().get_parent().update()
	#get_parent().get_parent().clear_cont()


func show_economy_policy_info():
	var panel = Functions.create_details_panel($Economy)
	panel.show_economy_policy_info(party.economy_policy)


func show_trade_policy_info():
	var panel = Functions.create_details_panel($TradePolicy)
	panel.show_trade_policy_info(party.trade_policy)


func show_military_policy_info():
	var panel = Functions.create_details_panel($ForeignPolicy)
	panel.show_military_policy_info(party.military_policy)
