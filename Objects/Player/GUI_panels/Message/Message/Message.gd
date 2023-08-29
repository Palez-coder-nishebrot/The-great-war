extends Control

@onready var title = $Title
@onready var text = $Text

func set_title(tipe_of_message, object):
	title = $Title
	text = $Text
	if tipe_of_message == "research_completed":
		title.text = object.name_of_technology
		set_text_of_massage_research_completed(object.list_of_effects)
	
	elif tipe_of_message == "new_reform":
		pass
	
	else:
		breakpoint
	pass


func set_text_of_massage_research_completed(list_of_effects):
	text.text = "Эффекты:"
	for effect in list_of_effects:
		text.text += "\n"
		text.text += effect.get_effect()
		
	
func exit():
	queue_free()
