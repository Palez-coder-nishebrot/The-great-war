extends Area2D


export(String) var tipe_of_border = ""


func _ready():
	connect("mouse_entered", self, "mouse_entered")
	connect("mouse_exited", self, "mouse_exited")


func mouse_entered():
	print("entered")
	pass


func mouse_exited():
	pass
