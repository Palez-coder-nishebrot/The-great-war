extends ReformEffect

class_name ReformEffectMinSalary


func _init():
	target = "min_salary"


func activate_effects(client):
	client.economic_bonuses.min_salary_bonus += value


func deactivate_effects(client):
	client.economic_bonuses.min_salary_bonus -= value
