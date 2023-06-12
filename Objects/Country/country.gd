@tool
extends Node

@export var national_color: Color


func get_provinces():
	return get_node("ProvinceContainer").get_children()


func _get_configuration_warnings():
	var hint = ""
	
	var has_country_border = false
	
	for ch in get_children():
		if ch.name == "CountryBorder":
			has_country_border = true
		
	if not has_country_border:
		hint = "Country not working without configured CountryBorder scene"
		
	var province_container = get_node_or_null("ProvinceContainer")
	
	if province_container == null:
		hint = "Country not working without ProvinceContainer scene"
	
		
	return hint
