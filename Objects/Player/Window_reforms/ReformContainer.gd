extends VBoxContainer


export var cotegory: String = ""

var list_of_buttons: Dictionary = {}
var list_of_buttons_ntb: Dictionary = {}

onready var example_button: Button = get_parent().get_parent().get_parent().get_node("Button")
onready var example_label: Label = get_parent().get_parent().get_parent().get_node("Label")
onready var parent: Object = get_parent().get_parent().get_parent()

func spawn_buttons():
	var label = example_label.duplicate()
	label.text = cotegory
	add_child(label)
	
	var level = 1
	var list_of_reforms = Reforms.reforms[cotegory]
	for i in list_of_reforms:
		spawn_button_reform(list_of_reforms, i, level)
		level = level + 1


func spawn_button_reform(list_of_reforms, reform, level):
	var button = example_button.duplicate()
	button.text = reform
	button.result = list_of_reforms[reform]
	button.cotegory = cotegory
	button.parent = self
	list_of_buttons[button] = level
	list_of_buttons_ntb[level] = button
	add_child(button)
	check_disable_of_button(button, level)


func check_disable_of_button(button, level):
	set_disable_of_button(button, level)
	if get_parent().name == "EconomyReforms":
		set_disable_of_economy_button(button, level)
	else:
		set_disable_of_button(button, level)


func set_disable_of_economy_button(button, level):
	if Players.player.adopted_reforms[cotegory] == level:
		button.update_text_for_active_buttons()
		button.disabled = true
	else:
		button.disabled = false


func set_disable_of_button(button, level):
	if Players.player.adopted_reforms[cotegory] == level:
			button.update_text_for_active_buttons()
	button.disabled = true


func update_economy_reforms(button):
	update_reforms(button, false)
	

func update_economy_and_policy_reforms(button):
	update_reforms(button, true)
	

func update_reforms(button, bool_):
	for i in get_children():
		if i is Button:
			i.disabled = bool_
			i.text = i.name_of_button
			
	button.disabled = not bool_
	button.update_text_for_active_buttons()
