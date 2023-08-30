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


func _ready():
	SceneStorage.game.connect("new_day", new_day)


func new_day():
	if technology_branch != null:
		if technology_branch.level >= technology_branch.branch_levels.find(technology):
			texture_normal = load("res://Graphics/Sprites/GUI/technology_button_2.png")
	pass


func _pressed():
	parent.show_technology(self)
