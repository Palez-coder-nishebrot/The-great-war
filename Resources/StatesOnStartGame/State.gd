extends Resource

class_name StateOnStartGame

@export var name_of_state: String = ""

@export var list_of_regions: PackedStringArray

@export var middle_value_education: int = 50

@export var government_form: Resource
@export var ideology: Resource

@export var national_color: Color = Color(0.556863, 0.447059, 0.431373)
@export var national_flag: Texture2D
@export var national_id: String


@export var popularity_of_parties: Dictionary = {
	"liberals": 30,
	"socialists": 15,
	"libertarians": 5,
	"communists": 5, 
	"fascists": 0, 
	"conservators": 45,
}
@export var names_of_parties: Dictionary = {
	"liberals": "",
	"socialists": "",
	"libertarians": "",
	"communists": "", 
	"fascists": "", 
	"conservators": "",
}
