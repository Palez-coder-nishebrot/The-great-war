extends ReformEffect

class_name ReformEffectMinSalary

@export var effect_name: String = "min_salary"

func _init():
	target = "min_salary"


func activate_effects(client):
	client.economic_bonuses.min_salary_bonus += value


func deactivate_effects(client):
	client.economic_bonuses.min_salary_bonus -= value
