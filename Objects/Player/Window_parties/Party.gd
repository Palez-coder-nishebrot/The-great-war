extends Control

var party: Object

func update():
	$VBoxContainer/Button.text = party.name_of_party
	$VBoxContainer/Label6.text = "Идеология: "              + party.ideology
	$VBoxContainer/Label.text  = "Экономическая политика: " + party.economic_model
	$VBoxContainer/Label2.text = "Торговая политика: "      + party.trade_policy
	$VBoxContainer/Label4.text = "Популярность: "           + str(party.popularity)
