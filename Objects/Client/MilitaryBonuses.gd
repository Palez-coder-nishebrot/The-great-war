extends Node

class_name MilitaryBonuses

const list_of_all_units: Array = [
	"infantry", 
	"artillery", 
	"cavalry", 
	"stormtroopers", 
	"armored_car", 
	"tank",
	"combat_airplane", 
	"fighter_airplane", 
	"bomber_airplane", 
	"fleet"
]

var list_of_units: Array = [
	"infantry", 
	"artillery", 
	"cavalry", 
	"armored_car",
]

var list_of_fleet_units: Array = [
	"cruiser",
	"submarine",
	"raider",
]

var projectile_supply: int = 0
var ammo_supply:       int = 0

var infantry:         CharsOfUnit
var artillery:        CharsOfUnit
var cavalry:          CharsOfUnit
var stormtroopers:    CharsOfUnit
var armored_car:      CharsOfUnit
var tank:             CharsOfUnit
var combat_airplane:  CharsOfUnit
var fighter_airplane: CharsOfUnit
var bomber_airplane:  CharsOfUnit
var fleet:            CharsOfUnit


func set_object_of_units():
	for i in list_of_all_units:
		var obj = CharsOfUnit.new()
		obj.unit = i
		self.set(i, obj)
