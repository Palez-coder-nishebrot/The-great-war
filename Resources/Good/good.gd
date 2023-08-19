class_name Good
extends Resource

@export var name: String = "Название для отображения"
@export var base_price: int = 0
@export var min_price: int  = 0
@export var max_price: int  = 0

@export var icon: Texture2D

@export var dp_effiency_production: float = 1.0 #Не менять!
@export var factory_effiency_production: float = 1.0 #Не менять!


func get_based_good_production_effiency(enterprise):
	if enterprise is DP:
		return dp_effiency_production
	else:
		return factory_effiency_production
