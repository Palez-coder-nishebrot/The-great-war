extends Panel

var province 

onready var button_tipes_of_battalions:   Button = $Button_example
onready var button_battalion:             Button = $Button_example2
onready var label_divisions_in_training:  Label  = $Button_example3


func _ready():
	for i in Players.list_of_units:
		var button = button_tipes_of_battalions.duplicate()
		
		button.text = i
		button.visible = true
		
		$VBoxContainer.add_child(button)


func update_information(province_):
	province = province_
	visible = true
	$Button2.disabled = true
	$Label.text = ""
	
	clear_container($VBoxContainer2)
	clear_container($VBoxContainer3)
	show_divisions_in_training()
	check_tipe_of_battalions()


func check_tipe_of_battalions():
	for i in $VBoxContainer.get_children():
		if Players.player.units_for_training.has(i.text) and not Players.fleet_units.has(i.text):
			i.disabled = false
		else:
			i.disabled = true


func show_divisions_in_training():
	if province.training_units != null:
		for i in province.training_units.list_of_battalions:
			var label = label_divisions_in_training.duplicate()
			label.text = "Батальон: " + i.tipe_of_battalion
			label.visible = true
			$VBoxContainer3.add_child(label)


func clear_container(container):
	for i in container.get_children():
		i.queue_free()


func show_information_about_unit(unit):
	$Button2.disabled = false
	
	$Label.text = ""
	
	for i in Units.chars_of_units[unit]:
		$Label.text = $Label.text + i + ": " + str(Units.chars_of_units[unit][i])
		$Label.text = $Label.text + "\n"
		
	if $VBoxContainer2.get_children().size() != 8:
		var button = button_battalion.duplicate()
		button.text = unit
		button.visible = true
		$VBoxContainer2.add_child(button)


func start_training():
	var list_of_battalions = []
	
	for i in $VBoxContainer2.get_children():
		list_of_battalions.append(i.text)

	Units.create_division(province, list_of_battalions, Players.player)
	visible = false
	
	
func exit():
	visible = false
