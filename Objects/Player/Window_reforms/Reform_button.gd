extends Button


var cotegory: String

var result: Dictionary
var name_of_button: String
var parent:         Object
var player: Client = Players.player

func _ready():
	#connect("mouse_entered", self, "mouse_entered")
	#connect("mouse_exited", self, "mouse_exited")
	connect("pressed", self, "on_button_pressed")
	name_of_button = text
	pass


func update_text_for_active_reform_buttons():
	text = name_of_button + "(+)"


func update_text_for_active_buttons():
	text = name_of_button + "(*)"


func update_text_for_not_active_buttons():
	text = name_of_button


func on_button_pressed():
	if get_parent().get_parent().name == "EconomyReforms":
		get_parent().update_economy_reforms(self)
		Reforms.set_economy_reform(player, result, name_of_button, parent.list_of_buttons[self])
	else:
		var level = player.adopted_reforms[cotegory]
		var reform = parent.list_of_buttons_ntb[level].name_of_button
		var old_result = Reforms.reforms[cotegory][name_of_button]
		
		get_parent().update_economy_and_policy_reforms(self)
		Reforms.set_economy_or_policy_reform(player, old_result, result, cotegory, parent.list_of_buttons[self])
		
		get_parent().get_parent().update_economy_and_policy_reform_buttons()
#	Reforms.set_reform(result, Players.player, cotegory, name_of_button)
