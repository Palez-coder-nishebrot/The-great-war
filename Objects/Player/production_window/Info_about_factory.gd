extends Panel

var factory
@onready var parent = get_parent()

const closed_list: Dictionary = {false: "Закрыть", true: "Открыть"}
const subsidization_list: Dictionary = {true: "Да", false: "Нет"}

@onready var name_label: Label = $VBoxContainer/Name
@onready var income_label: Label = $VBoxContainer/Income
@onready var expenses_label: Label = $VBoxContainer/Expenses
@onready var budget_label: Label = $VBoxContainer/Budget
@onready var purchase_label: Label = $VBoxContainer/Purchase
@onready var workers_label: Label = $VBoxContainer/Workers
@onready var production_label: Label = $VBoxContainer/Production
@onready var ready_to_produce: Label = $VBoxContainer/ReadyToProduce


func update_information():
	if factory != null:
		if factory.province.player != Players.get_player_client():
			factory = null
			return
		else:
			show_information_about_factory()


func show_information_about_factory():
	
	name_label.text = factory.name_of_factory
	budget_label.text = "Бюджет: " + str(factory.money)
	income_label.text = "Доходы: " + str(factory.income)
	show_resourses()
	show_expenses()
	show_quantity_of_workers()
	show_bonuses_for_production()


func show_quantity_of_workers():
	workers_label.text = "Рабочие: " + str(factory.workers_quantity) + " Клерки: " + str(factory.clerks_quantity) + " Макс:" + str(factory.max_employed_number)


func show_expenses():
	expenses_label.text = "Расходы(" + str(factory.get_expenses()) + "):" + "\n"
	expenses_label.text += "*Зарплаты рабочим:" + str(factory.expenses_workers) + "\n"
	expenses_label.text += "*Закупка сырья:"    + str(factory.expenses_raw) + "\n"
	expenses_label.text += "*Закупка товаров для завода:" + str(factory.expenses_factory_equipment)


func show_resourses():
	purchase_label.text = ""
	var token = 1
	for raw in factory.raw_storage:
		if token == factory.raw_storage.size():
			purchase_label.text += raw.good.name + ": " + str(raw.quantity)
		else:
			purchase_label.text += raw.good.name + ": " + str(raw.quantity) + "\n"
			token = token + 1


func show_bonuses_for_production():
	var good = factory.good
	#var manager = factory.province.player.get_parent().factory_manager
	production_label.text = "Бонус к выпуску продукции от: \n"
	ready_to_produce.text = "Способен производить: " + str(factory.ready_to_produce)
	
	production_label.text += "*Производительность завода: x" + str(factory.enterprise_production_efficiency) + "\n"
	production_label.text += "*Эффективность выпуска продукции: " + str(factory.good_production_efficiency) + "ед." + "\n"
	production_label.text += "*Базовая эффективность выпуска продукции: " + str(good.factory_effiency_production) + "ед." + "\n"
	
	
func exit():
	visible = false
