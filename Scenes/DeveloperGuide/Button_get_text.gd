extends Button


func on_button_pressed():
	var parent = get_parent().get_parent()
	parent.open_file(parent.list_of_texts[text])
