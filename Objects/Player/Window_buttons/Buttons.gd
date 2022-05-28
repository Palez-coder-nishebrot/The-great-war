extends HBoxContainer


onready var list_of_buttons: Dictionary = {
	"Производство":   "window_production",
	"Экспорт/Импорт": "window_export_import",
	"Налоги":         "window_taxes",
	"Реформы":        "window_reform",
	"Парламент":      "window_parties",
	"Рынки":          "window_markets",
}


func on_button_pressed(button):
	
	var player = Players.player
	var panel = player.get(list_of_buttons[button.text])
	
	for i in list_of_buttons:
		if player.get(list_of_buttons[i]) != panel:
			player.get(list_of_buttons[i]).visible = false
		
	panel.visible = not panel.visible
