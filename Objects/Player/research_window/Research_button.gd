extends TextureButton 

@onready var label = $Label

var technology_branch: TechnologyBranch
var technology:        Technology

var available: bool = false

var level: int
var parent: Object
var text: String = "":
	set(value):
		text = value
		$Label.text = text


func _pressed():
	parent.show_technology(self)
