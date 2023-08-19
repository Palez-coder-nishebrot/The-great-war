extends Resource


@export var policy_name: String = ""
@export var military_goods_consumption: float = 0.0 #Потребление припасов
@export var avaliable_military_expenses: Array[int] # (Array, int)
@export var war_weariness_growth: float # Прирост военной усталости
