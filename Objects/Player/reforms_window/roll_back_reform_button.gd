extends Button



func update(level, reform_type):
	var window = get_parent().get_parent().get_parent()
	
	if reform_type == "soc_reform" and window.back_soc_refoms_avaliable:
		disabled = false
	
	elif reform_type == "pol_reform" and window.back_pol_refoms_avaliable:
		disabled = false
	
	else:
		disabled = true
	
	if level == 0:
		disabled = true
		

#func _pressed():
#	var reform_cotegory = get_parent().reform_cotegory
#
#	reform_cotegory.roll_back_reform(Players.get_player_client())
#	get_parent().update_info(reform_cotegory)
