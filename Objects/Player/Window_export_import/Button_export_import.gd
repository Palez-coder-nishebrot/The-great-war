extends Label

var good: String = ""

func _ready():
	good = text
	get_parent().get_parent().get_parent().connect("update", self, "update_information")


func update_information(export_, import_):
	text = good + "\n"
	if import_[good] == 0:
		text += "Экспорт: " + str(export_[good]) 
	else:
		text += "Импорт: " + str(import_[good])
		
	text += "\n" + "Выпуск: " + str(Players.player.output[good])
	
