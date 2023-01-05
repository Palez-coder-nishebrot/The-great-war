extends HBoxContainer

onready var tipes_of_technologies = {
	"Военное дело": get_parent().get_node("HBoxContainer"),
	"Экономика":    get_parent().get_node("HBoxContainer2"),
}

func button_pressed(text):
	for i in tipes_of_technologies:
		tipes_of_technologies[i].visible = false
	tipes_of_technologies[text].visible = true
