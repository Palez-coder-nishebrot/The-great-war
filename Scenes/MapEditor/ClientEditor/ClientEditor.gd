extends Node2D


const speed_of_camera: int            = 50
const speed_of_zoom:   float          = 0.1
const MAX_zoom:        float          = 2.5
const MIN_zoom:        float          = 1.0

onready var camera: Camera2D = $Camera2D
onready var region_panel = $CanvasLayer/RegionPanel
onready var household_panel = $CanvasLayer/HouseholdPanel


func _process(delta):
	if Input.is_action_pressed("W"):# and position.y >= 1200:
		camera.position.y -= speed_of_camera
	if Input.is_action_pressed("A"):# and position.x >= 1600:
		camera.position.x -= speed_of_camera
	if Input.is_action_pressed("S"):# and position.y <= 2100:
		camera.position.y += speed_of_camera
	if Input.is_action_pressed("D"):# and position.x <= 2400:
		camera.position.x += speed_of_camera


func save_changes():
	var list = get_parent().provinces.values()

	var file = SavedRegions.new()
	
#	for i in list:
#		var list_of_fact = []
#		for fact in i["factories"]:
#			list_of_fact.append(load(fact))
#		i["factories"] = list_of_fact
#			if fact == "Gas_factory":
#				i["factories"].erase("Gas_factory")
#				i["factories"].append("Fuel_factory")

#		i["resources"] = change_resources(i["resources"])
#		i["resources"] = [i["resources"][0]]
#		i["factory_workers"] = i["factory_workers"] * 2
	file.regions = list
	ResourceSaver.save("res://Objects/Provinces/SavedRegions.tres", file)


#func change_resources(list):
#	var new_list = []
#	for i in list:
#		new_list.append(load("res://Resources/Good/" + i + ".tres"))
#	return new_list
