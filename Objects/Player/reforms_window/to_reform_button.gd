extends Button


# Called when the node enters the scene tree for the first time.
func update(level, max_level, reform_type):
	var window = get_parent().get_parent().get_parent()
	
	if reform_type == "soc_reform" and window.soc_refoms_avaliable:
		disabled = false
	
	elif reform_type == "pol_reform" and window.pol_refoms_avaliable:
		disabled = false
	
	else:
		disabled = true
	
	if level == max_level:
		disabled = true


#func _pressed():
#	var reform_cotegory = get_parent().reform_cotegory
#
#	reform_cotegory.to_reform(Players.get_player_client())
#	get_parent().update_info(reform_cotegory)
