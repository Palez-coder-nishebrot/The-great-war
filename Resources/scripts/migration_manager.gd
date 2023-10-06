extends Resource


class_name MigrationManager


var pop_unit:       PopulationUnit

var want_to_upgrade_status:   int = 0
var want_to_downgrade_status: int = 0

var region_haves_jobs_for_craftsmen: bool = false
var region_haves_factories:          bool = false
var unemployed_percent:             float = 0.0
var literacy:                       float = 0.0
var army_cost:                      float = 0.0
var bureaucracy_cost:               float = 0.0
var education_cost:                 float = 0.0


func set_values(_pop_unit, list_of_buildings, ec_manager):
	pop_unit = _pop_unit
	literacy           = pop_unit.literacy
	unemployed_percent = pop_unit.unemployed_quantity / pop_unit.quantity
	army_cost          = ec_manager.army_cost
	bureaucracy_cost   = ec_manager.bureaucracy_cost
	education_cost     = ec_manager.education_cost
	
	region_haves_jobs_for_craftsmen = false
	region_haves_factories          = false
	
	for i in list_of_buildings:
		if i.real_max_employed_number - i.get_workers_quantity() > 0 and i.closed == false:
			region_haves_jobs_for_craftsmen = true
	
	if list_of_buildings.size() > 0:
		region_haves_factories = true
	else:
		region_haves_factories = false
	
	set_want_to_upgrade_status()
	set_want_to_downgrade_status()


func set_want_to_upgrade_status():
	var value     = 0.0
	var pluralism = pop_unit.pluralism
	
	if pluralism > 1.0:
		value += 0.01
	
	if pluralism > 3.0:
		value += 0.01
	
	if pluralism > 6.0:
		value += 0.01
	
	if unemployed_percent < 0.1:
		value += 0.01
	
	if unemployed_percent > 0.1:
		value -= 0.01
	
	if unemployed_percent > 0.2:
		value -= 0.01
	
	if unemployed_percent > 0.3:
		value -= 0.01
	
	if unemployed_percent > 0.5:
		value -= 0.01
	
	if unemployed_percent > 0.6:
		value -= 0.01
	
	if literacy > 30:
		value += 0.01
	
	if literacy > 40:
		value += 0.01
	
	if literacy > 50:
		value += 0.01
	
	if literacy > 60:
		value += 0.01
	
	if literacy > 70:
		value += 0.01
	
	if literacy > 80:
		value += 0.01
	
	if literacy > 90:
		value += 0.01
	
	want_to_upgrade_status = value * pop_unit.quantity
	pop_unit.want_to_upgrade_status = want_to_upgrade_status


func set_want_to_downgrade_status():
	var value     = 0.0
	var pluralism = pop_unit.pluralism
	
	if unemployed_percent > 0.1:
		value += 0.01
	
	if unemployed_percent > 0.2:
		value += 0.01
	
	if unemployed_percent > 0.3:
		value += 0.01
	
	if unemployed_percent > 0.5:
		value += 0.01
	
	if unemployed_percent > 0.6:
		value += 0.01
	
	if unemployed_percent > 0.7:
		value += 0.01
	
	if unemployed_percent > 0.8:
		value += 0.01
	
	if unemployed_percent > 0.9:
		value += 0.01
	
	want_to_downgrade_status = value * pop_unit.quantity
	pop_unit.want_to_downgrade_status = want_to_downgrade_status
