extends ReformEffect

class_name ReformEffectEducationEfficiency


func _init():
	target = "education_efficiency"


func activate_effects(client):
	client.population_manager.education_efficiency += value


func deactivate_effects(client):
	client.population_manager.education_efficiency -= value
