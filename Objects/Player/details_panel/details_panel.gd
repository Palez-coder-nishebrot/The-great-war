extends Panel

@onready var text = $text
const answers = {true: "Yes",
				false: "No"}

func _ready():
	global_position = get_global_mouse_position()


func connect_parent(parent):
	parent.connect("mouse_exited", Callable(self, "mouse_exited"))


func mouse_exited():
	queue_free()


func clear_text():
	text.text = ""

func show_resource_output_details(dp):
	clear_text()
	text.text += "Товар: " + dp.good.name + "\n"
	text.text += "Продано " + str(dp.selling_goods_quantity) + " ед. за " + str(dp.income) + " Крон" + "\n"
	text.text += "Выпуск = Эфф-ть пр-ва * кол-во рабочих" + "\n"
	text.text += "\n"
	
	text.text += "Эфф-ть пр-ва: "                + str(dp.get_DP_production_efficiency()) + "\n"
	text.text += "Базовая эфф-ть пр-ва товара: " + str(dp.get_based_good_effiency_production()) + "\n"
	text.text += "Эфф-ть пр-ва товара: "         + str(dp.get_good_production_efficiency()) + "\n"
	text.text += "Производительность ДП: "       + str(dp.get_production_efficiency())


func show_raw(storage_good, factory):
	clear_text()
	var required_quantity = storage_good.get_good_required_quantity(factory)
	text.text += "Товар: " + storage_good.good.name + "\n"
	text.text += "Требуется " + storage_good.good.name + " " + str(required_quantity) + " ед." + "\n"
	
	if factory.ready_to_produce == true:
		text.text += "На складе " + storage_good.good.name + " " + str(required_quantity) + " ед."
	else:
		text.text += "На складе " + storage_good.good.name + " " + str(storage_good.quantity) + " ед."


func show_economy_policy_info(economy_policy):
	clear_text()
	text.text += tr(economy_policy.policy_name) + "\n"
	text.text += "Стоимость фабрик: +" + str(economy_policy.factory_cost) + "%" + "\n"
	text.text += "Стоимость инф-ры: +" + str(economy_policy.infrastructure_cost) + "%" + "\n"
	text.text += "Субсидии пром-сти: " + answers[economy_policy.subsidization] + "\n"
	text.text += "Постройка непр. фабрик:  " + answers[economy_policy.building_not_profit_factories] + "\n"
	text.text += "Частная собственность: " + answers[economy_policy.private_property]


func show_trade_policy_info(trade_policy):
	clear_text()
	text.text += tr(trade_policy.policy_name) + "\n"
	text.text += "Инвестирование: " + answers[trade_policy.investing]


func show_military_policy_info(military_policy):
	clear_text()
	text.text += tr(military_policy.policy_name) + "\n"
	text.text += "Потребление припасов: " + str(military_policy.military_goods_consumption) + "%" + "\n"
	text.text += "Прирост военной усталости: " + str(military_policy.war_weariness_growth) + "%" + "\n"
