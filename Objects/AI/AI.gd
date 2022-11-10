extends Client

class_name AI


func _ready():
	connect("research_completed", self, "research_completed")


func research_completed():
	pass


func hold_debate():
	pass
