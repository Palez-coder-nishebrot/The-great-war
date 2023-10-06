extends Node

class_name ConstructionProject

var remaining_days: int = 3

var factory_type: Resource
var region
var economy_manager


func _init(type, region_, ec_manager):
	ManagerDay.connect("check_projects", Callable(self, "new_day"))
	factory_type = type
	region       = region_
	economy_manager   = ec_manager
	remaining_days = factory_type.construction_days
	
	#region.player.accounting_manager.projects_list.append(self)


func new_day():
	remaining_days -= 1
	if remaining_days == 0:
		spawn_factory()
		#region.player.accounting_manager.projects_list.erase(self)


func spawn_factory():
	var factory = factory_type.generate_factory(region, economy_manager)
	region.client_owner.economy_manager.factories_list.append(factory)
	region.factories_list.append(factory)
	region.set_enterprises_efficiency(economy_manager)
	queue_free()
