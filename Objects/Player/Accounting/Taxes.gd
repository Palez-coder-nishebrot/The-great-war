extends Panel

onready var accounting = Players.player.accounting
onready var state_bank = $MoneyOfStateBank
onready var income_in_budget = $ScrollContainer/VBoxContainer/Income
onready var spending_in_budget = $ScrollContainer/VBoxContainer/Expenses
onready var balance = $Balance

var list_of_bool: Dictionary = {
	true: "Да",
	false: "Нет"
}

#
#func _ready():
#	#update()
#	pass


func update_information():
	for i in $ScrollContainer/VBoxContainer.get_children():
		if i.name_of_reform != "":
			#if economy[i.name_of_reform] 
			i.text = i.text_for_update + ": " + str(accounting[i.name_of_reform])
	state_bank.text = "Государственный банк:" + str(Players.player.money_of_state_bank)
	balance.text = "Дневное сальдо: " + str(Players.player.balance)
	income_in_budget.text = "Доходы(" + str(Players.player.income_in_budget) + ")"
	spending_in_budget.text = "Расходы(" + str(Players.player.spending_in_budget) + ")"
