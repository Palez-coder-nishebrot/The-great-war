extends VBoxContainer

var reform: Object
export var cotegory:     String = ""
export var name_of_file: String = ""

var list_of_buttons: Dictionary = {}
var list_of_buttons_ntb: Dictionary = {}

onready var example_button: Button = get_parent().get_parent().get_parent().get_node("Button")
onready var example_label: Label = get_parent().get_parent().get_parent().get_node("Label")
onready var parent: Object = get_parent().get_parent().get_parent()

func spawn_buttons():
	reform = load("res://Resources/Reforms/" + get_parent().name + "/" + name_of_file + ".tres")
	
	var label = example_label.duplicate()
	label.text = name_of_file
	add_child(label)

	for effect in reform.effects:
		var button = example_button.duplicate()
		button.text = effect.effect
		button.cotegory = reform.target
		button.name_of_reform = reform.reform
		button.parent = self
		button.effect = effect
		add_child(button)
		
		if cotegory == "EconomicReforms":
			if reform.effects[0] == effect:
				button.disabled = true
		
		else:
			if reform.effects[0] == effect:
				button.update_text_for_activing_buttons()
			button.disabled = true


func update_buttons(bool_):
	for i in get_children():
		if i is Button:
			i.disabled = bool_
#	var folder = Directory.new()
#	folder.open(path_to_folder)
#	folder.list_dir_begin(true, true)
#
#	var file_name = folder.get_next()
#	while file_name != "":
#		reform = load(path_to_folder + file_name)
#		for i in reform.effects:
#			var button = example_button.duplicate()
#
#			button.cotegory = reform.target
#			button.name_of_reform = reform.reform
#			button.parent = self
#			button.effects = reform.effects
#
#			add_child(button)
#
#		file_name = folder.get_next()

#func spawn_button_reform(list_of_reforms, reform, level):
#	var button = example_button.duplicate()
#	button.text = reform
#	button.result = list_of_reforms[reform]
#	button.cotegory = cotegory
#	button.parent = self
#	list_of_buttons[button] = level
#	list_of_buttons_ntb[level] = button
#	add_child(button)
#	check_disable_of_button(button, level)


#func check_disable_of_button(button, level):
#	set_disable_of_button(button, level)
#	if get_parent().name == "EconomyReforms":
#		set_disable_of_economy_button(button, level)
#	else:
#		set_disable_of_button(button, level)
#
#
#func set_disable_of_economy_button(button, level):
#	if Players.player.adopted_reforms[cotegory] == level:
#		button.update_text_for_active_buttons()
#		button.disabled = true
#	else:
#		button.disabled = false
#
#
#func set_disable_of_button(button, level):
#	if Players.player.adopted_reforms[cotegory] == level:
#			button.update_text_for_active_buttons()
#	button.disabled = true
#
#
#func update_economy_reforms(button):
#	update_reforms(button, false)
#
#
#func update_economy_and_policy_reforms(button):
#	update_reforms(button, true)
#
#
#func update_reforms(button, bool_):
#	for i in get_children():
#		if i is Button:
#			i.disabled = bool_
#			i.text = i.name_of_button
#
#	button.disabled = not bool_
#	button.update_text_for_active_buttons()
