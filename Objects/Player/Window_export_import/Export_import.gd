extends Panel


onready var goods: Dictionary = {
	"Уголь":     $VBoxContainer/Resourses_container/Good,
	"Железо":    $VBoxContainer/Resourses_container/Good2,
	"Нефть":     $VBoxContainer/Resourses_container/Good3,
	"Резина":    $VBoxContainer/Resourses_container/Good4,
	"Хлопок":    $VBoxContainer/Resourses_container/Good5,
	"Зерно":     $VBoxContainer/Resourses_container/Good6,
	"Скот":      $VBoxContainer/Resourses_container/Good7,
	"Селитра":   $VBoxContainer/Resourses_container/Good8,
	"Древесина": $VBoxContainer/Resourses_container/Good9,
	"Лекарственные_растения": $VBoxContainer/Military_container/Good10,#$VBoxContainer/Resourses_container/Good10,
	
	"Сталь":           $VBoxContainer/Factory_goods_container/Good,
	"Стекло":          $VBoxContainer/Factory_goods_container/Good2,
	"Ткань":           $VBoxContainer/Factory_goods_container/Good3,
	"Электрозапчасти": $VBoxContainer/Factory_goods_container/Good4,
	"Автозапчасти":    $VBoxContainer/Factory_goods_container/Good5,
	"Удобрения":       $VBoxContainer/Factory_goods_container/Good6,
	"Пиломатериалы":   $VBoxContainer/Factory_goods_container/Good7,
	"Динамит":         $VBoxContainer/Factory_goods_container/Good8,
	
	"Автомобили":      $VBoxContainer/Tech_container/Good,
	"Тракторы":        $VBoxContainer/Tech_container/Good2,
	"Телеграфы":       $VBoxContainer/Tech_container/Good3,
	"Телефоны":        $VBoxContainer/Tech_container/Good4,
	"Радио":           $VBoxContainer/Tech_container/Good5,
	"Миксеры":         $VBoxContainer/Tech_container/Good6,
	"Электропечи":     $VBoxContainer/Tech_container/Good7,
	"Холодильники":    $VBoxContainer/Tech_container/Good8,
	
	"Мебель":          $VBoxContainer/Civilian_container/Good,
	"Спиртное":        $VBoxContainer/Civilian_container/Good2,
	"Одежда":          $VBoxContainer/Civilian_container/Good3,
	"Обогреватели":    $VBoxContainer/Civilian_container/Good4,
	"Хлеб":            $VBoxContainer/Civilian_container/Good5,
	"Консервы":        $VBoxContainer/Civilian_container/Good6,
	"Топливо":         $VBoxContainer/Civilian_container/Good7,
	"Табак":           $VBoxContainer/Civilian_container/Good8,
	"Лекарства":       $VBoxContainer/Civilian_container/Good9,
	
	"Снаряды":              $VBoxContainer/Military_container/Good,
	"Боеприпасы":           $VBoxContainer/Military_container/Good2,
	"Пулеметы":             $VBoxContainer/Military_container/Good3,
	"Артиллерия":           $VBoxContainer/Military_container/Good4,
	"Аэропланы":            $VBoxContainer/Military_container/Good5,
	"Магазинные_винтовки":  $VBoxContainer/Military_container/Good6,
}




func update_information():
	for i in goods:
		update_text(goods[i], i)
	
	
func update_text(label, good):
	var import_ = Players.player.import_of_goods[good]
	var export_ = Players.player.export_of_goods[good]
	label.text = good + "\n"
	if import_ == 0:
		label.text += "Экспорт: " + str(export_) 
	else:
		label.text += "Импорт: " + str(import_)
		
	label.text += "\n" + "Выпуск: " + str(Players.player.output[good])
