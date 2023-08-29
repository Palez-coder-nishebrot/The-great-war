extends Resource

class_name Reform

@export var levels: Array[ReformLevel] = []
@export var reform_name: String = ""

@export_enum("soc_reform", "pol_reform") var reform_type = "soc_reform"
