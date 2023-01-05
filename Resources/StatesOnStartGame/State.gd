extends Resource

class_name StateOnStartGame

export(String) var name_of_state = ""

export(PoolStringArray) var list_of_regions

export(int) var middle_value_education = 50

export(String, "monarchy", "republic", "soviet_republic", "fascist_dictatorship", "military_dictatorship") var form_of_goverment = "monarchy"
export(String, "liberals", "socialists", "communists", "fascists", "conservators") var ideology = "conservators"

export(Color)   var national_color = Color(0.556863, 0.447059, 0.431373)
export(Texture) var national_flag
export(String)  var national_id


export(Dictionary) var popularity_of_parties: Dictionary = {
	"liberals": 30,
	"socialists": 15,
	"libertarians": 5,
	"communists": 5, 
	"fascists": 0, 
	"conservators": 45,
}
export(Dictionary) var names_of_parties = {
	"liberals": "",
	"socialists": "",
	"libertarians": "",
	"communists": "", 
	"fascists": "", 
	"conservators": "",
}
