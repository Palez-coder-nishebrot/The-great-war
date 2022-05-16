extends Panel


func update():
	var policy = Players.player.policy
	for i in policy["Партии"]:
		var panel = load("res://Objects/Player/Window_parties/Party.tscn").instance()
		panel.party = i
		panel.update()
		$ScrollContainer/VBoxContainer.add_child(panel)
	$ScrollContainer/VBoxContainer.add_child(load("res://Objects/Player/Window_parties/Party.tscn").instance())
