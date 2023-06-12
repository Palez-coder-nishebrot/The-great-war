extends Button

@export var value: float = 0.0
@onready var parent = get_parent()


func _gui_input(event):
	if event is InputEventMouseButton and event.is_pressed():
		Players.player.economy_manager.set_tax(value, parent.variable)
