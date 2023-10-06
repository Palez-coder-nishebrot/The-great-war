extends Resource

class_name PopulationUnit

const new_generation_max: float = 3.0

var clerk_res       = load("res://Resources/population_types/clerk.tres")
var craftsmen_res   = load("res://Resources/population_types/factory_worker.tres")

var soc_reform_desire:     float = 0.0 # Макс. 10.0
var pol_reform_desire:     float = 0.0 # Макс. 10.0
var pluralism:             float = 0.0 # Макс. 10.0
var aggressiveness:        float = 0.0 # Макс. 10.0

var want_to_downgrade_status:   int  = 0
var want_to_upgrade_status:     int  = 0
var upgraded_status_quantity:   int  = 0
var downgraded_status_quantity: int  = 0

var usual_needs_satisfied:  int = 0
var luxury_needs_satisfied: int = 0

var welfare:             int = 0
var quantity:            int = 0
var unemployed_quantity: int = 0
var money:             float = 0
var income:            float = 0
var expenses:          float = 0
var literacy:          float = 40.0 # Макс. 100.0
var parties_supporter:     PartiesSupporter    = PartiesSupporter.new()
var reform_desire_manager: ReformDesireManager = ReformDesireManager.new(increase_value)
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


func migrate_in_region(new_pop_unit: Province, pop_quantity):
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
	
	increase_value("aggressiveness", growth, 10.0, 0.0)


func update_pluralism(government_form: GovernmentForm, economy_manager: EconomyManager):
	var tax    = economy_manager.get(population_type.tax_variable)
	var value = -0.5
	
	if parties_supporter.government_form_is_republic(government_form):
		value += 0.1
	
	match luxury_needs_satisfied:
		0:
			value += 0.0
		1:
			value += 0.1
		2:
			value += 0.2
		3:
			value += 0.3
		4:
			value += 0.4
		
	if literacy > 10:
		value += 0.1
	if literacy > 30:
		value += 0.1
	if literacy > 50:
		value += 0.1
	if literacy > 70:
		value += 0.1
	if literacy > 90:
		value += 0.1
	
	increase_value("pluralism", value, 10.0, 0.0)


func add_soc_reform_desire(number):
	if soc_reform_desire + number > 0:
		soc_reform_desire += number
	else: soc_reform_desire = 0.0


func add_pol_reform_desire(number):
	pol_reform_desire += number


func update_literacy(education_efficiency, education_cost):
	if education_cost > 0:
		var points = (education_efficiency + education_cost) * 0.1
		increase_value("literacy", points, 100.0, 0.0)


func increase_welfare(need_good: NeededGood):
	welfare += 1
	
	if need_good.is_luxury_need:
		luxury_needs_satisfied += 1
	else:
		usual_needs_satisfied  += 1


func allocate_workers_to_factories(factory, workers_variable: String, avaliable_jobs: int):
	if avaliable_jobs >= unemployed_quantity:
		add_workers_in_factory(factory, workers_variable, unemployed_quantity)
	else:
		add_workers_in_factory(factory, workers_variable, avaliable_jobs)


func add_workers_in_factory(factory, workers_variable, quantity_):
	var getter = factory.get(workers_variable)
	factory.set(workers_variable, getter + quantity_)
	unemployed_quantity -= quantity_
	pass


func fire_workers_from_factory(factory: Enterprise, workers_variable: String, quantity_: int):
	var getter = factory.get(workers_variable)
	factory.set(workers_variable, getter - quantity_)
	unemployed_quantity += quantity_


func increase_workers_on_factory(factory, value):
	if population_type == load("res://Resources/population_types/factory_worker.tres"):
		factory.workers_quantity += value
	else:
		factory.clerks_quantity += value


func set_natural_population_increase(pop_growth_modifier):
	var value = 0.0
	
	if quantity == 0:
		breakpoint
#	match welfare:
#		1:
#			value += 0.01
#		2:
#			value += 0.01
#		3:
#			value += 0.02
#		4:
#			value += 0.03
#		5:
#			value += 0.04
#		6:
#			value += 0.05
	
	if literacy > 80:
		value -= 0.01
	
	var number = 1 #+ snapped(value * quantity, 0)
	
	increase_population(number)
	population_growth    = number
	

func increase_population(number):
	quantity            += number
	if population_type == clerk_res or population_type == craftsmen_res:
		unemployed_quantity += number


func increase_value(variable_name, number, max_value, min_value):
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
		
		if workers_variable != "":
			for i in enterprises_list:
				var workers_in_factory = i.get(workers_variable)
				if workers_in_factory >= number:
					fire_workers_from_factory(i, workers_variable, number)
					delete_all_unemployed_population()
					return
				else:
					fire_workers_from_factory(i, workers_variable, workers_in_factory)
					delete_all_unemployed_population()
		else:
			quantity -= number


func delete_all_unemployed_population():
	quantity -= unemployed_quantity
	unemployed_quantity = 0
