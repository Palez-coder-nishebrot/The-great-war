extends Panel

onready var accounting = Players.player.accounting


var list_of_bool: Dictionary = {
	true: "Да",
	false: "Нет"
}

#
#func _ready():
#	#update()
#	pass


func update_information():
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.name_of_reform != "":
			#if economy[i.name_of_reform] 
			i.text = i.text_for_update + ": " + str(accounting[i.name_of_reform])
