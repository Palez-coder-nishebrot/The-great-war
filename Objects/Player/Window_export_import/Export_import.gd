extends Panel

signal update(market)

onready var containers: Array = [
	$VBoxContainer/Resourses_container,
	$VBoxContainer/Factory_goods_container,
	$VBoxContainer/Civilian_container,
	$VBoxContainer/Tech_container,
	$VBoxContainer/Military_container
]


func _ready():
	for container in containers:
		for i in container.get_children():
			if i.get_class() != "Label":
				i.add_child(load("res://Objects/Player/Window_export_import/Label_export_import.tscn").instance())


func update_information():
	emit_signal("update", Players.player.export_of_goods, Players.player.import_of_goods)
	
