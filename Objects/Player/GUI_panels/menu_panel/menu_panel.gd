extends Panel



func exit_game():
	get_tree().quit()


func resume_game():
	visible = false


func _on_visibility_changed():
	if visible == true:
		SceneStorage.timer.set_pause(true)
