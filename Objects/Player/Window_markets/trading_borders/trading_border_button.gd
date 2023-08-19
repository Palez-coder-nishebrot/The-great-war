extends Button


@export var value: float = 0


func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		get_parent().update_trading_borders(self)
