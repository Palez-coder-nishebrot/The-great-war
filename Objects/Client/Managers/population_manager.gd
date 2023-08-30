extends Node


class_name PopulationManager

var government_form_getter:        Callable
var ruling_party_getter:           Callable
var population_units_getter:       Callable
var pop_unit_for_migration_getter: Callable
var education_cost_getter:         Callable


var education_efficiency: float = 0.0
var pop_growth_modifier:  float = 0.0

var military_fatigue: float = 0.0
var revanchism:       float = 0.0

var _thread = Thread.new()
var _semaphore = Semaphore.new()
var _mutex     = Mutex.new()
var _exit      = false


func _init(client):
	SceneStorage.game.connect("new_day", Callable(self, "execute_thread"))
	_thread.start(Callable(self, "thread_executor"))
	population_units_getter       = Callable(client, "get_population_units_list")
	pop_unit_for_migration_getter = Callable(client, "get_pop_unit_for_migration")
	ruling_party_getter           = Callable(client, "get_ruling_party")
	government_form_getter        = Callable(client, "get_government_form")
	education_cost_getter         = Callable(client, "get_education_cost")
	

func execute_thread():
	_semaphore.post()
	#thread_debugger()


func thread_debugger():
	loop_executor()


func thread_executor():
	while true:
		_semaphore.wait()
		
		if _exit == true:
			break
		
		loop_executor()


func loop_executor():
	var government_form      = government_form_getter.call()
	var ruling_party         = ruling_party_getter.call()
		
	for unit in population_units_getter.call():
		if unit.quantity > 0:
			update_pop_unit_chars(unit, government_form, ruling_party)


func update_pop_unit_chars(unit, government_form, ruling_party):
	var unemployment_percent = snappedf(unit.unemployed_quantity / unit.quantity, 0.01)
	var pluralism            = unit.pluralism
	var literacy             = unit.literacy
	var welfare              = unit.welfare
	var pop_type             = unit.population_type
	
	unit.update_aggressiveness(ruling_party, government_form)
	
	if SceneStorage.game.data_manager.is_first_day_in_week():
		unit.update_literacy(education_efficiency, education_cost_getter.call())
		unit.increase_population_quantity(pop_growth_modifier)
		unit.update_pluralism(government_form)
		unit.reform_desire_manager.update_soc_reform_desire(unemployment_percent,
			pluralism, literacy, welfare, pop_type)


func _exit_tree():
	_exit = true
	_semaphore.post()
	_thread.wait_to_finish()
