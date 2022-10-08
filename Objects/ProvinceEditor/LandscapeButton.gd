extends Button

var list_of_landscape: Array = [
	"Степь",
	"Лес",
	"Болота",
	"Горы",
	"Пустыня",
	"Равнины",
]

func _gui_input(event):
	if pressed == true:
		change_landscape()


func change_landscape():
	var province = get_parent().get_parent().province
	var landscape = province.landscape
	
	var pos = list_of_landscape.find(landscape) + 1
	
	if pos == 6: pos = 0
	
	province.landscape = list_of_landscape[pos]
	text = list_of_landscape[pos]
	var list = get_parent().get_parent().province_editor.list_of_landscape_of_provinces
	
	list[province.name_of_tile] = list_of_landscape[pos]
