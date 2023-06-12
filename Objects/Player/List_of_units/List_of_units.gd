extends ScrollContainer

@onready var player = get_parent().get_parent()

func show_units():
	clear()
	visible = true
	for i in player.list_of_active_units:
		var unit = load("res://Objects/Player/List_of_units/Unit.tscn").instantiate()
		unit.division = i
		unit.set_info(i)
		$HBoxContainer.add_child(unit)


func clear():
	for i in $HBoxContainer.get_children():
		i.queue_free()
