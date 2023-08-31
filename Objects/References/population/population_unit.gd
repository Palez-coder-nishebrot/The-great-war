extends Resource

class_name PopulationUnit

const new_generation_max: float = 3.0

var clerk_res       = load("res://Resources/population_types/clerk.tres")

var soc_reform_desire:     float = 0.0 # Макс. 10.0
var pol_reform_desire:     float = 0.0 # Макс. 10.0
var pluralism:             float = 0.0 # Макс. 10.0
var aggressiveness:        float = 0.0 # Макс. 10.0

var want_to_upgrade_status:     int  = 0
var upgraded_status_quantity:   int  = 0
var downgraded_status_quantity: int  = 0

var welfare:             int = 0
var quantity:            int = 0
var unemployed_quantity: int = 0
var money:             float = 0
var income:            float = 0
var expenses:          float = 0
var literacy:          float = 40.0 # Макс. 100.0
var parties_supporter:     PartiesSupporter    = PartiesSupporter.new()
var reform_desire_manager: ReformDesireManager = ReformDesireManager.new(add_soc_reform_desire, add_pol_reform_desire)
var soc_migration_manager: SocMigrationManager = SocMigrationManager.new()
var population_type:   Resource
var region:            Object

var new_generation:    float = 0.0

var population_growth: float = 0.0

var internal_migration_chance: float = -100.0


func _init():
	SceneStorage.population_manager.connect("clear_income_variable", clear_income_variable)


func clear_income_variable():
	income = 0.0


func migrate_in_region(new_pop_unit: Region, pop_quantity):
	quantity -= pop_quantity
	new_pop_unit.quantity += pop_quantity


func update_aggressiveness(ruling_party: PoliticalParty, government_form: GovernmentForm):
	var growth = -0.1
	
	match welfare:
		0: 
			growth += 0.5
		1: 
			growth += 0.2
		2: 
			growth += 0.1
		
	if parties_supporter.conservators_is_majority():
		growth -= 0.1
	
	if parties_supporter.majority_agree_with_ruling_party(ruling_party):
		growth -= 0.1
	
	if parties_supporter.government_form_is_republic(government_form):
		growth += 0.1
	
	increase_value("aggressiveness", growth, 10.0)


func update_pluralism(government_form: GovernmentForm):
	var growth = -0.5
	growth += check_literacy_for_pluralism()
	
	if parties_supporter.government_form_is_republic(government_form):
		growth += 0.1
	
	match welfare:
		0:
			growth += 0.3
		1:
			growth += 0.2
		2:
			growth += 0.1
		3:
			growth += 0.2
		4:
			growth += 0.3
		5:
			growth += 0.4
	
	increase_value("pluralism", growth, 10.0)


func check_literacy_for_pluralism():
	if literacy > 90:
		return 0.4
	
	elif literacy > 70:
		return 0.3
	
	elif literacy > 50:
		return 0.2
	
	elif literacy > 40:
		return 0.1
	
	else:
		return 0.0


func add_soc_reform_desire(number):
	if soc_reform_desire + number > 0:
		soc_reform_desire += number
	else: soc_reform_desire = 0.0


func add_pol_reform_desire(number):
	pol_reform_desire += number


func update_literacy(education_efficiency, education_cost):
	if education_cost > 0:
		var points = (education_efficiency + education_cost) * 0.1
		increase_value("literacy", points, 100.0)


func allocate_workers_to_factories(factory, workers_variable: String, avaliable_jobs):
	if avaliable_jobs >= unemployed_quantity:
		add_workers_in_factory(factory, workers_variable, unemployed_quantity)
	else:
		add_workers_in_factory(factory, workers_variable, avaliable_jobs)


func add_workers_in_factory(factory, workers_variable, quantity_):
	var getter = factory.get(workers_variable)
	factory.set(workers_variable, getter + quantity_)
	unemployed_quantity -= quantity_


func fire_workers_from_factory(factory: Enterprise, workers_variable: String, quantity_: int):
	var getter = factory.get(workers_variable)
	factory.set(workers_variable, getter - quantity_)
	unemployed_quantity += quantity_


func increase_workers_on_factory(factory, value):
	if population_type == load("res://Resources/population_types/factory_worker.tres"):
		factory.workers_quantity += value
	else:
		factory.clerks_quantity += value


func increase_population_quantity(pop_growth_modifier):
	var value = 0.0
	
	match welfare:
		1:
			value += 0.01
		2:
			value += 0.01
		3:
			value += 0.02
		4:
			value += 0.03
		5:
			value += 0.04
		6:
			value += 0.05
	
	if literacy > 80:
		value -= 0.01
	
	var number = 1 + snapped(value * quantity, 0)
	
	if number > 0:
		increase_population(number)
		population_growth = number
	

func increase_population(number):
	unemployed_quantity += number
	quantity            += number


func increase_value(variable_name, number, max_value):
	var variable_value = get(variable_name)
	
	if variable_value + number < 0:
		set(variable_name, 0.0)
	
	elif variable_value + number > max_value:
		set(variable_name, max_value)
	
	else: 
		set(variable_name, number + variable_value)


func reduce_population(number: int, enterprises_list: Array, workers_variable: String):
	if unemployed_quantity >= number:
		quantity            -= number
		unemployed_quantity -= number
	else:
		number   -= unemployed_quantity
		delete_all_unemployed_population()
		
		for i in enterprises_list:
			var workers_in_factory = i.get(workers_variable)
			if workers_in_factory >= number:
				fire_workers_from_factory(i, workers_variable, number)
				delete_all_unemployed_population()
				return
			else:
				fire_workers_from_factory(i, workers_variable, workers_in_factory)
				delete_all_unemployed_population()


func delete_all_unemployed_population():
	quantity -= unemployed_quantity
	unemployed_quantity = 0
