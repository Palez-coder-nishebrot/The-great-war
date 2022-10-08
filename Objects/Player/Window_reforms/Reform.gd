extends Panel


onready var player = get_parent().get_parent()


func _ready():
#	clear_container($VBoxContainer/HBoxContainer)
#	clear_container($VBoxContainer/HBoxContainer2)
#
	
	set_buttons($VBoxContainer/EconomyReforms)
	set_buttons($VBoxContainer/SocialReforms)
	set_buttons($VBoxContainer/PolicyReforms)


func set_buttons(container):
	for i in container.get_children():
		i.spawn_buttons()


func clear_container(container):
	for i in container.get_children():
		if i.get_class() == "Button":
			i.queue_free()


func clear_buttons(container, button):
	for i in container.get_children():
		if i.get_class() == "Button":
			i.disabled = false
	
	button.disabled = true


func update_buttons(container):
	for i in container.get_children():
		for y in i.get_children():
			if y.get_class() == "Button":
				y.disabled = true


func check_available_reform():
	#breakpoint
	if Players.player.policy["Реформы"]["Принятие_соц_реформ"] == true:
		open_available_reform($VBoxContainer/SocialReforms)
	
	elif Players.player.policy["Реформы"]["Принятие_пол_реформ"] == true:
		open_available_reform($VBoxContainer/PolicyReforms)


func open_available_reform(container):
	for i in container.get_children():
		var button = i.list_of_buttons_ntb[Players.player.adopted_reforms[i.cotegory] + 1]
		button.disabled = false
		button.update_text_for_active_reform_buttons()
		
	#breakpoint

