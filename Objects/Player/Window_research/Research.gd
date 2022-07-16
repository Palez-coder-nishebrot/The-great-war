extends Panel

onready var game = get_parent().get_parent().get_parent()
onready var player = get_parent().get_parent()


onready var cotegories: Dictionary = {
	$HBoxContainer/Army:         "ruling_of_army",
	$HBoxContainer/Tech:         "armored_vehicles",
	$HBoxContainer/Heavy_weapon: "heavy_weapon",
	$HBoxContainer/Light_weapon: "light_weapon",
	
	$HBoxContainer2/Factory_production:   "factory_production",
	$HBoxContainer2/Farm_production:      "farm_production",
	$HBoxContainer2/Resourses_production: "resourses_production",
	$HBoxContainer2/Railways:             "railways",
	$HBoxContainer/Fleet:                 "fleet",
}


var technology: Dictionary = {
	button             = null,
	technology         = null,
	tipe_of_technology = null,
}


func _ready():
	spawn_buttons()
	disable_buttons()
	update_information()


func spawn_buttons():
	for cotegory in cotegories:
		var num = 0
		for technology_ in Research.get(cotegories[cotegory]):
			var button = $Button.duplicate()
			button.visible = true
			button.text = technology_
			button.name = str(num)
			button.level = num
			button.tipe_of_technology = cotegory.get_children()[0].text
			button.technology = technology_
			num = num + 1
			cotegory.add_child(button)


func disable_buttons():
	var cotegory_
	var levels_of_technologies = player.levels_of_technologies
	for container in get_children():
		for cotegory in container.get_children():
			for element in cotegory.get_children():
				if element.get_class() == "Button":
					if levels_of_technologies[cotegory_] != int(element.name[-1]):
						element.disabled = true
				
				else:
					cotegory_ = element.text


func update_information():
	var cotegory_

	for cotegory in cotegories:
		for technology_ in cotegory.get_children():
			if technology_.get_class() == "Button":
				
				#print(technology_.name[-1] + 1, player.levels_of_technologies[cotegory_])
				if int(technology_.name[-1]) == player.levels_of_technologies[cotegory_]:
					technology_.disabled = false
				
				else:
					technology_.disabled = true
			
			else:
				cotegory_ = technology_.text


func show_technology(button):
	if player.researching_object != null:
		$Button_start.disabled = true
	else: 
		$Button_start.disabled = false
	
	technology.button             = button
	technology.technology         = button.technology
	technology.tipe_of_technology = button.tipe_of_technology
	show_results_of_technology()


func show_results_of_technology():
	clear_scroll_containers()
	var dict = Research.get(Research.research[technology.tipe_of_technology])[technology.technology]
	var massage = Research.return_results_of_research(dict)
	
	var label = $Example.duplicate()
	label.text = massage
	$ScrollContainer2/VBoxContainer.add_child(label)


func clear_scroll_containers():
	for i in $ScrollContainer2/VBoxContainer.get_children():
		i.queue_free()


func start_research():
	$Button_start.disabled     = true
	technology.button.disabled = true
	$Label.text = technology.technology + ": " + "0%"
	
	player.researching_object = load("res://Objects/Party/Researching.gd").new()
	
	player.researching_object.technology.button             = technology.button
	player.researching_object.technology.technology         = technology.technology
	player.researching_object.technology.tipe_of_technology = technology.tipe_of_technology
	
	player.researching_object.player                        = player
	player.researching_object.game                          = game
	
	player.researching_object.start()
