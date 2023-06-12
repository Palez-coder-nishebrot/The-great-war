extends Resource

class_name SavedFactory

@export var time_of_construction: int = 0
@export var income: int               = 0
@export var expenses_workers: int     = 0
@export var expenses_purchase: int    = 0
@export var expenses_mechanisms: int  = 0
@export var max_employed_number: int  = 2
@export var quantity_of_workers: float = 0.0

@export var subsidization: bool        = false
@export var closed: bool               = false
@export var in_construction: bool      = false


@export var name_of_factory: String = ""
@export var good: String = ""
@export var money: int = 500

@export var expansion: Resource
