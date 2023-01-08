extends Panel


onready var player = get_parent().get_parent()

onready var economy_reforms_container = $Reforms/EconomicReforms
onready var social_reforms_container = $Reforms/SocialReforms
onready var political_reforms_container = $Reforms/PoliticalReforms

var activing_buttons: Array = []
var buttons_for_changing_text: Array = []

func _ready():
	set_buttons(economy_reforms_container)
	set_buttons(social_reforms_container)
	set_buttons(political_reforms_container)
	
	check_available_reform("political_reform")
	check_available_reform("social_reform")

func set_buttons(container):
	for i in container.get_children():
		i.spawn_buttons()
#ягей


func check_available_reform(tipe_of_reform):
	if tipe_of_reform == "political_reform":
		check_cotegories("political_reforms_container")
	
	if tipe_of_reform == "social_reform":
		check_cotegories("social_reforms_container")
		

func check_cotegories(target):
	var reforms_container = get(target)
	var reform = player.reforms_manager.get(reforms_container.get_children()[1].reform.target).activing_reform
#	var cotegory
#	var children_of_cot
#	var button 
	#breakpoint
	for i in reforms_container.get_children():
		reform = player.reforms_manager.get(i.reform.target).activing_reform
		get_button(i, i.get_children(), reform)


func get_button(_cotegory, children_of_cot, effect):
	var button 
	for i in children_of_cot:
		if i.get_class() != "Label":
			if i.effect == effect:
				button = i
				break
				
	var count = children_of_cot.find(button) + 1
	
	if count == children_of_cot.size():
		button.disabled = true
		
	else:
		buttons_for_changing_text.append(button)
		#button.update_text_for_not_active_buttons()
		children_of_cot[count].update_text_for_active_reform_buttons()
		children_of_cot[count].disabled = false
		activing_buttons.append(children_of_cot[count])
