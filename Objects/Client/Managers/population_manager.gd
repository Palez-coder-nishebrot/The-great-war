extends Node


class_name PopulationManager

var government_form_getter:        Callable
var ruling_party_getter:           Callable
var population_units_getter:       Callable
var pop_unit_for_migration_getter: Callable


var education_efficiency: float = 0.0
var pop_growth_modifier:  float = 0.0


var _thread = Thread.new()
var _semaphore = Semaphore.new()
var _mutex     = Mutex.new()
var _exit = false


func _init(client):
	_thread.start(Callable(self, "thread_executor"))
	ManagerDay.connect("update_internal_migration", Callable(self, "execute_thread"))
	population_units_getter       = Callable(client, "get_population_units_list")
	pop_unit_for_migration_getter = Callable(client, "get_pop_unit_for_migration")
	ruling_party_getter           = Callable(client, "get_ruling_party")
	government_form_getter        = Callable(client, "get_government_form")
	

func execute_thread():
	_semaphore.post()
	#thread_debugger()


#func thread_debugger():
#	update_aggressiveness()
#	update_internal_migration()


func thread_executor():
	while true:
		_semaphore.wait()
		
		if _exit == true:
			break
		
		var government_form      = government_form_getter.call()
		var ruling_party         = ruling_party_getter.call()
		
		for unit in population_units_getter.call():
			if unit.quantity > 0:
				var unemployment_percent = unit.unemployed_quantity / unit.quantity
				var pluralism            = unit.pluralism
				var literacy             = unit.literacy
				var welfare              = unit.welfare
				var pop_type             = unit.population_type
				
				unit.update_aggressiveness(ruling_party, government_form)
				unit.update_literacy()
				unit.reform_desire_manager.update_soc_reform_desire(unemployment_percent,
					pluralism, literacy, welfare, pop_type)


func update_internal_migration(unit):
	unit.internal_migration_chance = 0
	var chance = unit.get_internal_migration_chance() * 10
	var value = Functions.rng(0, 100)

	if chance > value:
		var pop_quantity = unit.get_pop_units_for_migration()
		var new_unit = pop_unit_for_migration_getter.call(unit.income, unit.population_type)
		if new_unit != false:
			unit.migrate_in_region(new_unit, pop_quantity)
		else:
			print("Go abroad!")


func _exit_tree():
	_exit = true
	_semaphore.post()
	_thread.wait_to_finish()
