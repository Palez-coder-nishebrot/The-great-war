extends Control

var party: Object

func update():
	if party != null:
		var pop = str(party.popularity)
		
		$NameOfParty.text = party.name_of_party + "(" + pop + ")"
		$Ideology.text = tr(party.ideology)
		$Economy.text  = "Эк. политика: " + tr(party.economic_policy)
		$TradePolicy.text = "Торговая политика: " + tr(party.trade_policy)
		$ForeignPolicy.text = "Внешняя политика: " + tr(party.foreign_policy)
