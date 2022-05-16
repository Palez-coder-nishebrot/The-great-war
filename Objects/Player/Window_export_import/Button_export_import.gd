extends Button

var good: String = ""

func _ready():
	good = text
	get_parent().get_parent().get_parent().connect("update", self, "update_information")


func update_information(export_, import_):
	if import_[good] == 0:
		$Label.text = "Экспорт: " + str(export_[good]) 
	else:
		$Label.text = "Импорт: " + str(import_[good])
