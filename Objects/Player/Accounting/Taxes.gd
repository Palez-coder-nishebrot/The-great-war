extends Panel

@onready var container = $ScrollContainer/VBoxContainer
@onready var state_bank = $MoneyOfStateBank
@onready var income_in_budget = $ScrollContainer/VBoxContainer/Income
@onready var spending_in_budget = $ScrollContainer/VBoxContainer/Expenses
@onready var balance = $Balance

var list_of_bool: Dictionary = {
	true: "Да",
	false: "Нет"
}

#
#func _ready():
#	#update()
#	pass


func update_information():
	var client = Players.player
	for i in container.get_children():
		if i.get_class() == "Label" and i.variable != "":
			i.text = i.text_for_update + ": " + str(client.accounting_manager.get(i.variable))

#	state_bank.text = "Государственный банк:" + str(Players.player.factory_cost)
	balance.text = "Дневное сальдо: " + str(client.accounting_manager.daily_balance)
	income_in_budget.text = "Доходы(" + str(client.accounting_manager.income) + ")"
	spending_in_budget.text = "Расходы(" + str(client.accounting_manager.expenses) + ")"
