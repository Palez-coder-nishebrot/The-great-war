extends HBoxContainer

var province
var household

func update_information():
	$Button2.text = str(household.quanity)
	$Button3.text = province.name_of_tile
	$Button5.text = str(household.lack)

