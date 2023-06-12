extends Resource


@export var needs_of_workers: Dictionary = {
	"grain": 0.1,
	"beasts": 0.1,
	"alcohol": 0.1,
	"clothes": 0.1,
	"furniture": 0.1,
	"radio": 0.1,
	"phone": 0.1,
	"gas": 0.1,
	"cars": 0.1,
	"plane": 0.1,
}

@export var needs_of_factory_workers: Dictionary = {
	"grain": 0.1,
	"beasts": 0.1,
	"alcohol": 0.1,
	"clothes": 0.1,
	"furniture": 0.1,
	"radio": 0.1,
	"phone": 0.1,
	"gas": 0.1,
	"cars": 0.1,
	"plane": 0.1,
}


@export var needs_of_clerks: Dictionary = {
	"grain": 0.1,
	"beasts": 0.1,
	"alcohol": 0.1,
	"clothes": 0.1,
	"furniture": 0.1,
	"radio": 0.1,
	"phone": 0.1,
	"gas": 0.1,
	"cars": 0.1,
	"plane": 0.1,
}

func return_needs_for_household(soc_class, good):
	if soc_class == "Worker":
		return needs_of_workers[good]
	elif soc_class == "Proletarian":
		return needs_of_factory_workers[good]
	else:
		return needs_of_clerks[good]
