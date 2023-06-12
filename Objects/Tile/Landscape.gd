extends Resource

class_name Landscape

@export var landscape: String = "Fields"
# Леса, Холмы, Горы, Равнины


func check_debuffs():
	match landscape:
		"Fields":
			return create_debuff_value(1.0, 1.0, 1, 0)
		"Forests":
			return create_debuff_value(1.0, 1.0, 0, 1)
		"Hills":
			return create_debuff_value(0.9, 0.9, -1, 2)
		"Mountains":
			return create_debuff_value(0.8, 0.8, -2, 3)


func create_debuff_value(factory_efficiency, supply, speed, defense):
	return {
		"factory_efficiency": factory_efficiency,
		"supply":             supply,
		"speed":              speed,
		"defense":            defense,
	}
