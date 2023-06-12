extends Panel

var region
@onready var parent = get_parent().get_parent()

@onready var append_worker_button = $VBoxContainer/AppendWorkers
@onready var append_factory_worker_button = $VBoxContainer/AppendFactoryWorkers
@onready var append_clerk_button = $VBoxContainer/AppendClerks
#onready var container_of_households = $VBoxContainer/ListOfHouseholds
@onready var container_of_resources = $VBoxContainer/ListOfResources
@onready var container_of_factories = $VBoxContainer/ListOfFactories

@onready var railways_button = $VBoxContainer/AppendRailways

const levels_of_railways: Array = [0, 1, 2, 3]

func set_info_about_region(region):
	self.region = region
	$VBoxContainer/NameOfRegion.text = region.name_of_region
	railways_button.text = "Железные дороги: " + str(region.railways)
	set_households()
	set_resources()
	set_factories()
	
	append_worker_button.update()
	append_factory_worker_button.update()
	append_clerk_button.update()


func set_households():
	append_worker_button.update()
	append_factory_worker_button.update()
#	append_worker_button
#	for i in container_of_households.get_children():
#		i.queue_free()
#
#	for i in region.list_of_households:
#		var panel = parent.household_panel.duplicate()
#		container_of_households.add_child(panel)
#
#		panel.soc_class_button.text = i.soc_class
#		panel.household = i
#		panel.parent = self


func set_resources():
	for i in container_of_resources.get_children():
		i.queue_free()
	
	for i in region.resources:
		var button = get_parent().get_node("ResourceButton").duplicate()
		button.good = i
		button.parent = self
		button.icon = i.icon
		container_of_resources.add_child(button)
		

func set_factories():
	for i in container_of_factories.get_children():
		i.queue_free()
	
	for i in region.list_of_buildings:
		var button = get_parent().get_node("FactoryButton").duplicate()
		button.parent = self
		button.name_of_factory = i.name_of_factory
		button.text = i.name_of_factory
		container_of_factories.add_child(button)


#func append_household(soc_class, array):
#	region.set(soc_class, region.get(array) + 1)
#	var household = SavedHousehold.new()
#	household.soc_class = "Worker"
#	region.list_of_households.append(household)
#	set_households()


func append_railways():
	var count = levels_of_railways.find(region.railways) + 1
	if levels_of_railways.size() < count + 1:
		count = 0
	region.railways = levels_of_railways[count]
	railways_button.text = "Железные дороги: " + str(region.railways)
	parent.get_parent().provinces[region.name_of_region].railways = region.railways
