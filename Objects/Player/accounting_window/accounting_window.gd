extends Panel

@onready var container = $ScrollContainer/VBoxContainer
@onready var state_bank = $MoneyOfStateBank
@onready var income_in_budget = $ScrollContainer/VBoxContainer/Income
@onready var spending_in_budget = $ScrollContainer/VBoxContainer/Expenses
@onready var balance = $Balance
@onready var investment_pool = $investment_pool

var list_of_bool: Dictionary = {
	true: "Да",
	false: "Нет"
}

#
#func _ready():
#	#update()
#	pass


func update_information():
	var client = Players.get_player_client()
	var accounting_manager = client.accounting_manager
	var economy_manager    = client.economy_manager
	for i in container.get_children():
		if i.get_class() == "Label" and i.variable != "":
			i.text = i.text_for_update + ": " + str(client.accounting_manager.get(i.variable))

	investment_pool.text = "Инвест. пул: " + str(snappedf(economy_manager.investment_pool, 0.1))
	balance.text = "Дневное сальдо: " + str(accounting_manager.daily_balance)
	income_in_budget.text = "Доходы(" + str(accounting_manager.income) + ")"
	spending_in_budget.text = "Расходы(" + str(accounting_manager.expenses) + ")"
