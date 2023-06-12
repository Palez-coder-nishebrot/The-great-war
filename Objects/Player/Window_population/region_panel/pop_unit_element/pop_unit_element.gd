extends HBoxContainer

@onready var welfare_label = $Chars/welfare
@onready var quantity_label = $Chars/quantity
@onready var income_label = $Chars/income

func update_info(pop_unit):
	welfare_label.text  = "Благосостояние: " + str(pop_unit.welfare)
	quantity_label.text = "Количество: "     + str(pop_unit.quantity)
	income_label.text = "Доходы: "           + str(pop_unit.income)
