extends Resource

class_name PopulationType

@export var migration_manager: MigrationManager

@export var population_growth_modifier: float = 0.0
@export var index_in_pop_types_list:      int = 0
@export var display_name:              String = ""
@export var workers_variable:          String = ""
@export var enterprises_list_variable: String = ""
@export var tax_variable:              String = ""
@export var needs: Array[NeededGood]        = []

@export var upgrade_class_paths:   Array[String] = []
@export var downgrade_class_paths: Array[String] = []
