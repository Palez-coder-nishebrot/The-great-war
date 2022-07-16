extends Panel


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	set_buttons($VBoxContainer/HBoxContainer)
	set_buttons($VBoxContainer/HBoxContainer2)


func set_buttons(container):
	for i in container.get_children():
		var booll = false
		var cotegory = i.name
		var list = Reforms.reforms[cotegory]
		var label = $Label.duplicate()
		label.text = cotegory
		i.add_child(label)
		
		for y in list:
			var button = $Button.duplicate()
			button.text = y
			button.result = list[y]
			button.cotegory = cotegory
			
			if booll == false:
				button.disabled = true
				booll = true
			i.add_child(button)
