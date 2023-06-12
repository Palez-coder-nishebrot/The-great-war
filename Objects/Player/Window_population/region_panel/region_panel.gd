extends HBoxContainer

@onready var region_name_label = $region_name
@onready var pop_unit_labour = $pop_unit_element
@onready var pop_unit_worker = $pop_unit_element2
@onready var pop_unit_clerk = $pop_unit_element3

var region: Object


func update():
	var pop_list = region.population.population_types
	region_name_label.text = region.name_of_tile
	
	pop_unit_labour.update_info(pop_list[0])
	pop_unit_worker.update_info(pop_list[1])
	pop_unit_clerk.update_info(pop_list[2])
