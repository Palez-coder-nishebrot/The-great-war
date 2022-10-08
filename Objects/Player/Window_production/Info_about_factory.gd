extends Panel

var factory
onready var parent = get_parent()

const closed_list: Dictionary = {false: "Закрыть", true: "Открыть"}
const subsidization_list: Dictionary = {true: "Да", false: "Нет"}

onready var name_label: Label = $VBoxContainer/Name
onready var income_label: Label = $VBoxContainer/Income
onready var expenses_label: Label = $VBoxContainer/Expenses
onready var budget_label: Label = $VBoxContainer/Budget
onready var purchase_label: Label = $VBoxContainer/Purchase
onready var workers_label: Label = $VBoxContainer/Workers
onready var production_label: Label = $VBoxContainer/Production


func update_information():
	if factory != null:
		if factory.province.player != Players.player:
			factory = null
			return
		else:
			if factory.tipe == "factory":
				show_information_about_factory()
			else:
				show_information_about_military_factory()


func show_information_about_factory():
	
	name_label.text = Players.goods_to_factory[factory.good]
	budget_label.text = "Бюджет: " + str(factory.money)
	income_label.text = "Доходы: " + str(factory.income)
	show_resourses()
	show_expenses()
	show_quantity_of_workers()
	show_bonuses_for_production()


func show_information_about_military_factory():
	name_label.text = "Военный завод"
	income_label.text = "-"
	budget_label.text = "-"
	show_resourses()
	show_quantity_of_workers()
	show_bonuses_for_production()


func show_quantity_of_workers():
	workers_label.text = "Рабочие: " + str(factory.quantity_of_workers) + "/" + str(factory.max_employed_number)


func show_expenses():
	expenses_label.text = "Расходы(" + str(factory.expenses_workers + factory.expenses_purchase) + "):" + "\n"
	expenses_label.text += "*Зарплаты рабочим:" + str(factory.expenses_workers) + "\n"
	expenses_label.text += "*Закупка сырья:"    + str(factory.expenses_purchase)


func show_resourses():
	purchase_label.text = ""
	var token = 1
	for i in factory.purchase:
		if token == factory.purchase.size():
			purchase_label.text += i + ": " + str(factory.purchase[i])
		else:
			purchase_label.text += i + ": " + str(factory.purchase[i]) + "\n"
			token = token + 1


func show_bonuses_for_production():
	#var manager = factory.province.player.get_parent().factory_manager
	production_label.text = "Бонус к выпуску продукции от: \n"
	production_label.text += "*Сырье, производимое в провинции: +" + str(factory.get_bonuses_for_production_from_province() * 10) + "% \n"
	#production_label.text += "*Базовый бонус: x" + str(factory.check_based_bonuses_for_production()) + "\n"
	production_label.text += "*Промышленники: +" + str(factory.province.player.economic_bonuses.production_of_factories * 10) + "% \n"
	
	if factory.province.player.economic_bonuses.goods_from_technologies.has(factory.good):
		production_label.text += "*Технологии: +" + str(factory.province.player.economic_bonuses.goods_from_technologies[factory.good]) + "% \n"

func exit():
	visible = false
