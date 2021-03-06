extends HBoxContainer


onready var list_of_buttons: Dictionary = {
	"Производство":     "window_production",
	"Рынки":            "window_markets",
	"Бюджет":           "window_taxes",
	"Реформы":          "window_reform",
	"Предпарламент":    "window_parties",
	"Военные заказы":   "window_parties",
	"Население":        "window_population",
	"Технологии":       "window_research",
}


func on_button_pressed(button):
	
	var player = Players.player
	var panel = player.get(list_of_buttons[button.text])
	
	for i in list_of_buttons:
		if player.get(list_of_buttons[i]) != panel:
			player.get(list_of_buttons[i]).visible = false
		
	panel.visible = not panel.visible
