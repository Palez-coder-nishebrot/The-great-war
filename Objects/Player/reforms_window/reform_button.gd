extends Button


@export var reform_variable: String = ""

var reform_cotegory: ReformCotegory


func _ready():
	var r = Players.get_player_client().reforms_manager.get(reform_variable)
	reform_cotegory = r
	text = reform_cotegory.reform.reform_name


func _pressed():
	get_parent().get_parent().get_parent().update_reform_info(reform_cotegory)
	pass
	
