extends Resource

class_name Landscape

export(String) var landscape = "Fields"
# Леса, Холмы, Горы, Равнины


func check_debuffs():
	var factory_efficiency = 0
	var supply  = 0
	var speed   = 0
	var defense = 0
	match landscape:
		"Fields":
			factory_efficiency = 1.0
			supply             = 1.0
			speed              = 1
			defense            = 0
		"Forests":
			factory_efficiency = 1.0
			supply             = 1.0
			speed              = 0
			defense            = 1
		"Hills":
			factory_efficiency = 0.9
			supply             = 0.9
			speed              = -1
			defense            = 2
		"Mountains":
			factory_efficiency = 0.8
			supply             = 0.8
			speed              = -2
			defense            = 3
	return {
			"factory_efficiency": factory_efficiency,
			"supply":             supply,
			"speed":              speed,
			"defense":            defense,
	}
