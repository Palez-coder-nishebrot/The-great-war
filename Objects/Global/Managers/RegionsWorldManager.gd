extends Node

class_name RegionsWorldManager

var province_loader = ProvinceLoader.new()
var regions_list = []


func register_region(region):
	regions_list.append(region)
