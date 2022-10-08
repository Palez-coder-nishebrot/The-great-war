extends HBoxContainer

var province
var household
var tipe_of_soc_class

func update_information():
	$Tipe.text = tipe_of_soc_class
	$Welfare.text = str(household.welfare)
	if tipe_of_soc_class == "Домохозяйство":
		$Province.text = province.name_of_tile
		$Quanity.text = str(household.list_of_soc_classes.size())
		$Income.text = str(household.income)
	
	elif tipe_of_soc_class == "Промышленники":
		$Quanity.text = str(household.quantity)
		$Income.text = str(household.income)
		$Province.text = "-"

	else:
		$Province.text = province.name_of_tile
		$Quanity.text = "1"
		$Income.text = "-"
		

func tipe_button_pressed():
	get_parent().get_parent().get_parent().get_node("HouseholdPanel").population_manager = household
	get_parent().get_parent().get_parent().get_node("HouseholdPanel").update_information()
	get_parent().get_parent().get_parent().get_node("HouseholdPanel").visible = true
