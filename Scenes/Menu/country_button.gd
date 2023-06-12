extends Button

@onready var menu: Node2D = get_parent().get_parent().get_parent()

func _ready():
	var _err = connect("pressed", Callable(self, "on_button_pressed"))

func on_button_pressed():
	menu.ChangeScene(text)
