extends Panel

var province 

func _ready():
	for i in Players.list_of_units:
		var button = $VBoxContainer/Button.duplicate()
		
		button.text = i
		button.visible = true
		
		$VBoxContainer.add_child(button)
	$VBoxContainer/Button.queue_free()


func update_information(province_):
	province = province_
	visible = true
	$Button2.disabled = true
	
	for i in $VBoxContainer.get_children():
		if Players.player.units_for_training.has(i.text) and not Players.fleet_units.has(i.text):
			i.available = true
		else:
			i.available = false
	
	clear_container()


func clear_container():
	for i in $VBoxContainer2.get_children():
		i.queue_free()


func show_information_about_unit(unit):
	$Button2.disabled = false
	
	$Label.text = ""
	
	for i in Units.chars_of_units[unit]:
		$Label.text = $Label.text + i + ": " + str(Units.chars_of_units[unit][i])
		$Label.text = $Label.text + "\n"
		
	if $VBoxContainer2.get_children().size() != 8:
		var button = $Button3.duplicate()
		button.text = unit
		button.visible = true
		$VBoxContainer2.add_child(button)


func start_training():
	
	pass


func exit():
	visible = false
