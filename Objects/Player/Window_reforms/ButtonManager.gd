extends HBoxContainer


func update_economy_and_policy_reform_buttons():
	for i in get_children():
		var num = 1
		for button in i.get_children():
			if button is Button:
				button.disabled = true
				if num == Players.player.adopted_reforms[button.cotegory]:
					button.update_text_for_active_buttons()
				else:
					button.update_text_for_not_active_buttons()
				num = num + 1
