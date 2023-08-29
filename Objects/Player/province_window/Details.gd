extends Panel

@onready var text = $text


func _init(parent):
	parent.connect("mouse_exited", Callable(self, "mouse_exited"))


func mouse_exited():
	queue_free()


func clear_text():
	text.text = ""

func show_resource_output_details(dp):
	global_position = get_global_mouse_position()
	visible = true
	clear_text()
	text.text += "Товар: " + dp.good.name + "\n"
	text.text += "Продано " + str(dp.selling_goods_quantity) + " ед. за " + str(dp.income) + " Крон" + "\n"
	text.text += "Выпуск = Эфф-ть пр-ва * кол-во рабочих" + "\n"
	text.text += "\n"
	
	text.text += "Эфф-ть пр-ва: "                + str(dp.get_DP_production_efficiency()) + "\n"
	text.text += "Базовая эфф-ть пр-ва товара: " + str(dp.get_based_good_effiency_production()) + "\n"
	text.text += "Эфф-ть пр-ва товара: "         + str(dp.get_good_production_efficiency()) + "\n"
	text.text += "Производительность ДП: "       + str(dp.get_production_efficiency())
