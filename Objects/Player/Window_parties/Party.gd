extends Control

var party: Object

func update():
	if party != null:
		var pop = str(Players.player.policy["Поддержка_партий"][party.ideology])
		
		$NameOfParty.text = party.name_of_party + "(" + pop + ")"
		$Ideology.text = "Идеология: "              + party.ideology
		$Economy.text  = "Экономика: " + party.economic_model
		$TradePolicy.text = "Торговля: "      + party.trade_policy
		$ForeignPolicy.text = "Внешняя политика: "      + party.foreign_policy
