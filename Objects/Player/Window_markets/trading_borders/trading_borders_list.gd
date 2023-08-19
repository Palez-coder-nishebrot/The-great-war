extends HBoxContainer


var last_pressed_button: Button


func _ready():
	var button = get_children()[0]
	button.disabled = true
	last_pressed_button = button


func update_info(good):
	last_pressed_button.disabled = false
	var num = Players.get_player_client().economy_manager.trading_borders[good] * 0.1
	var button = get_children()[num]
	button.disabled = true
	last_pressed_button = button


func update_trading_borders(button):
	last_pressed_button.disabled = false
	button.disabled = true
	last_pressed_button = button
	Players.get_player_client().economy_manager.set_trading_borders(get_parent().good, button.value)
