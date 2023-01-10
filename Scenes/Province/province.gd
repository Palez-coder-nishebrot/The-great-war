tool
extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _get_configuration_warning():
	var hint = "Province not working without configured Border scene"
	
	for ch in get_children():
		if ch.name == "Border":
			hint = ""
		
	return hint
