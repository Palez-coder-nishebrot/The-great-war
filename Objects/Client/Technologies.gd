extends Node

class_name Technologies

const MILITARY_TECHNOLOGIES_FILES: Dictionary = {
	"army_managerment": "ArmyManagerement",
	"heavy_weapon":     "HeavyWeapon",
	"light_weapon":     "LightWeapon",
	"navy":             "Navy",
	}

const ECONOMIC_TECHNOLOGIES_FILES: Dictionary = {
	"farm_production":    "FarmProduction",
	"metallurgy":   "Metallurgy",
	"factory_production": "FactoryProduction",
	"supply":             "Supply",
	"economic_structures":"EconomicStructures"
}

var army_managerment: Array = []
var heavy_weapon:     Array = []
var light_weapon:     Array = []
var navy:             Array = []

var farm_production:    Array = []
var metallurgy:         Array = []
var factory_production: Array = []
var supply:             Array = []
var economic_structures:Array = []

var researching_technology: Technology
var client: Object

var research_time: int = 0


func _init(client):
	self.client = client
	set_technologies()


func set_technologies():
	set_cotegories(MILITARY_TECHNOLOGIES_FILES, "MilitaryTechnologies")
	set_cotegories(ECONOMIC_TECHNOLOGIES_FILES, "EconomyTechnologies")


func set_cotegories(TECHNOLOGIES_FILES, folder_name):
	for i in TECHNOLOGIES_FILES:
		var folder: Directory = Directory.new()
		var path: String = "res://Resources/Technologies/" + folder_name + "/" + TECHNOLOGIES_FILES[i] + "/"
		folder.open(path)
		folder.list_dir_begin(true, true)
		
		for y in range(5):
			var name_of_file = folder.get_next()
			var path_of_file: String = path + name_of_file
			var file = load(path_of_file).duplicate()
			file.cotegory = i
			get(i).append(file)
		get(i)[0].ready_for_researching = true


func start_research(technology):
	var pool_researching_points = technology.cost
	researching_technology = technology
	while pool_researching_points >= 0:
		yield(Players.player.game, "new_day")
		pool_researching_points -= client.researching_points
		client.researching_points = 0
	activate_effects()


func activate_effects():
	client.emit_signal("research_completed", researching_technology)
	
	for effect in researching_technology.list_of_effects:
		effect.activate_effects(client)
	update_ready_technology(researching_technology)
	
	researching_technology = null


func update_ready_technology(technology):
	var variable = get(technology.cotegory)
	var count = variable.find(technology)
	
	if count + 1 != variable.size():
		variable[count + 1].ready_for_researching = true
	technology.ready_for_researching = false
