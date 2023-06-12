extends Button

@onready var parent = get_parent().get_parent()
@export var good: Resource


func _ready():
	icon = good.icon


func _input(event):
	if event is InputEventMouseButton and get_rect().has_point(event.position):
		parent.showing_good = good
		parent.set_showing_map()
