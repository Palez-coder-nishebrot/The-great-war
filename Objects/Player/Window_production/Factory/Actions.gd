extends VBoxContainer

const closed_list: Dictionary = {false: "Закрыть", true: "Открыть"}
const subsidization_list: Dictionary = {true: "Да", false: "Нет"}

@onready var parent = get_parent()

func update_information():
	parent = get_parent()
	var factory = parent.factory
	$Subsidization.text = "Субсидии(" + subsidization_list[factory.subsidization] + ")"
	$Open.text = closed_list[factory.closed]
	update_information_about_expanding_factory()


func update_information_about_expanding_factory():
	var factory = parent.factory
	if factory.expansion_project != null:
		$Expansion.text = str(factory.expansion_project.time) + "/" + str(factory.expansion_project.max_time)
	else:
		$Expansion.text = "Расширение(НЕТ)"


func set_subsidization():
	var factory = parent.factory
	factory.subsidization = not factory.subsidization
	update_information()


func set_closing():
	var factory = parent.factory
	if factory.closed == false: #Нужно закрыть!
		factory.close_enterprise()
	else:
		factory.open_enterprise()
	update_information()


func expand_factory():
	parent.factory.expand_factory(Players.get_player_client())
