extends VBoxContainer

var division: Object

func _ready():
	$Button.connect("pressed", Callable(self, "choose_unit"))


func set_info(unit):
	pass


func choose_unit():
	var player = get_parent().get_parent().player
	player.list_of_active_units.clear()
	player.list_of_active_units.append(division)
	get_parent().get_parent().show_units()
