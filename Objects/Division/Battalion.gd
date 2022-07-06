extends Node


var chars: Dictionary = {
	"Атака":      0,
	"Оборона":    0,
	"ПВО":        0,
	"Дисциплина": 0,
	"Разведка":   0,
	"Скорость":   0,
}


var tipe_of_battalion: String


func set_chars():
	for i in Units.chars_of_units[tipe_of_battalion]:
		chars[i] = Units.chars_of_units[tipe_of_battalion][i]


