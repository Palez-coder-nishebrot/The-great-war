extends Resource


export var needs_of_workers: Dictionary = {
	"grain":         0.0,
	"beasts":        0.0,
	"clothes":       0.02,
	"furniture":     0.01,
	"glass":         0.01,
	"alcohol":       0.02,
	"tabaco":        0.0,
	"el_appliances": 0.01,
	"radio":         0.02,
	"phone":         0.02,
	"gas":           0.01,
	"cars":          0.01
}

export var needs_of_factory_workers: Dictionary = {
	"grain":         0.03,
	"beasts":        0.03,
	"clothes":       0.02,
	"furniture":     0.01,
	"glass":         0.0,
	"alcohol":       0.01,
	"tabaco":        0.0,
	"el_appliances": 0.01,
	"radio":         0.02,
	"phone":         0.02,
	"gas":           0.01,
	"cars":          0.01
}

export var needs_of_craftsmen: Dictionary = {
	"grain":         0.03,
	"beasts":        0.03,
	"clothes":       0.0,
	"furniture":     0.0,
	"glass":         0.0,
	"alcohol":       0.0,
	"tabaco":        0.03,
	"el_appliances": 0.01,
	"radio":         0.02,
	"phone":         0.02,
	"gas":           0.01,
	"cars":          0.01
}


func return_needs_for_household(soc_class, good):
	if soc_class == "Рабочий":
		return needs_of_workers[good]
	elif soc_class == "Фабричный рабочий":
		return needs_of_factory_workers[good]
	else:
		return needs_of_craftsmen[good]
