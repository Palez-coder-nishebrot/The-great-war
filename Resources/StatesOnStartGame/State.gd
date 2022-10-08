extends Resource

class_name StateOnStartGame

export(String) var name_of_state = ""

export(PoolStringArray) var list_of_regions

export(String, "monarchy", "republic", "soviet_republic", "fascist_dictatorship", "military_dictatorship") var form_of_goverment = "monarchy"
export(String, "liberals", "socialists", "communists", "fascists", "populists") var ideology = "populists"

export(Color)   var national_color = Color(0.556863, 0.447059, 0.431373)
export(Texture) var national_flag
export(String)  var national_id

#export(PoolStringArray) var v
