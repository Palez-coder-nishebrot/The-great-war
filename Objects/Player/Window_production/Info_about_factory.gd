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
		if factory.province.player != Players.player:
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
	workers_label.text = "Рабочие: " + str(factory.workers_quantity) + "/" + str(factory.max_employed_number)


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
	var client = factory.province.player
	var economic_bonuses = client.economic_bonuses
	var good = factory.good
	#var manager = factory.province.player.get_parent().factory_manager
	production_label.text = "Бонус к выпуску продукции от: \n"
	ready_to_produce.text = "Способен производить: " + str(factory.ready_to_produce)
	#production_label.text += "*Сырье, производимое в провинции: +" + str((factory.get_bonuses_for_production_from_province() - 1) * 100) + "% \n"
	#production_label.text += "*Базовый бонус: x" + str(factory.check_based_bonuses_for_production()) + "\n"
	#production_label.text += "*Промышленники: +0%"  + "\n"#+ str(factory.province.player.economic_bonuses.production_of_factories * 10) + "% \n"
	#production_label.text += "*Производительность фабрик: +" + str((factory.province.player.economic_bonuses.production_of_factories - 1) * 100) + "% \n"
	
	production_label.text += "*Базовый выпуск продукции x" + str(good.based_effiency_production) + "\n"
	production_label.text += "*Выпуск данной продукции: " + str(factory.good_production) + "ед."
	#production_label.text += "*Железные дороги: +" + str((factory.province.get_bonus_of_production().production_of_factory - 1) * 100) + "%"
	
	
func exit():
	visible = false
