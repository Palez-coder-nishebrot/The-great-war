extends Button


var cotegory: String

var effect:         Object
var name_of_reform: String
var parent:         Object
var player: Client = Players.player
var active: bool = true

func _ready():
	#connect("mouse_entered", self, "mouse_entered")
	#connect("mouse_exited", self, "mouse_exited")
	name_of_reform = text
	pass


func update_text_for_active_reform_buttons():
	text = name_of_reform + "(+)"


func update_text_for_activing_buttons():
	text = name_of_reform + "(*)"


func update_text_for_not_active_buttons():
	text = name_of_reform


func _gui_input(event):
	if event is InputEventMouseButton and pressed:
		player.reforms_manager.reform_activeted(effect, cotegory)
		#disabled = true
		
		if parent.cotegory == "EconomicReforms":
			parent.update_buttons(false)
			disabled = true
		else:
			disable_buttons()
			

func disable_buttons():
	for i in parent.parent.activing_buttons:
		i.disabled = true
		i.update_text_for_not_active_buttons()
		update_text_for_activing_buttons()
	parent.parent.activing_buttons.clear()
	
	for i in parent.parent.buttons_for_changing_text:
		if i.effect.target == effect.target:
			i.update_text_for_not_active_buttons()
			parent.parent.buttons_for_changing_text.erase(i)
	
