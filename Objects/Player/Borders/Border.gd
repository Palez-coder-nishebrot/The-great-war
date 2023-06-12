extends Area2D


@export var tipe_of_border: String = ""


func _ready():
	var _err = connect("mouse_entered", Callable(self, "mouse_entered"))
	var _err_ = connect("mouse_exited", Callable(self, "mouse_exited"))


func mouse_entered():
	print("entered")
	pass


func mouse_exited():
	pass
