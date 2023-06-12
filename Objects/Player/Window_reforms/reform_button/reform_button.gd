extends Button


@export var reform: Resource


func _ready():
	set_text(reform.level_name)
