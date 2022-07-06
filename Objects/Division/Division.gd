extends Node


var chars: Dictionary = {
	"Атака":      0,
	"Оборона":    0,
	"Дисциплина": 0,
	"Разведка":   0,
	"Скорость":   0,
}

var list_of_battalions: Array      = []
var player:             Object

var bonuses_of_units:   Dictionary = {}

func set_chars():
	for battalion in list_of_battalions:
		for characteristic in chars:
			chars[characteristic] += battalion.chars[characteristic]


