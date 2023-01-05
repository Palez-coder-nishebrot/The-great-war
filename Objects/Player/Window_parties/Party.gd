extends Control

var party: Object
onready var supporting_party_button: Object = $SupportParty

func update():
	if party != null:
		var pop = str(Players.player.parties_manager.popularity_of_parties[party.ideology])
		$NameOfParty.text = party.name_of_party + "(" + pop + ")"
		$Ideology.text = tr(party.ideology)
		$Economy.text  = "Эк. политика: " + tr(party.economic_policy)
		$TradePolicy.text = "Торговая политика: " + tr(party.trade_policy)
		$ForeignPolicy.text = "Внешняя политика: " + tr(party.foreign_policy)


func update_supporting_party_by_client():
	Players.player.update_supporting_party_by_client(party)
	
	get_parent().get_parent().get_parent().update()
	#get_parent().get_parent().clear_cont()
