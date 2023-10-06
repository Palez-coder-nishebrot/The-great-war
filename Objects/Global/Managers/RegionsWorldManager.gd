extends Node

class_name RegionsWorldManager

var province_loader                = ProvinceLoader.new()
var regions_list:  Array[Region]   = []
var province_list: Array[Province] = []


func register_region(region):
	regions_list.append(region)
	province_list.append_array(region.get_children())
