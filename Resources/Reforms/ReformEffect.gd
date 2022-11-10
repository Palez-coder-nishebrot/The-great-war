extends Resource

class_name ReformEffect

export(String) var effect = ""

export(int) var value = 0

export(String, "tax_on_poor_class", "tax_on_rich_class", "tariffs", "education", 
	"pensions", "min_salary", "day_working", "unemployment_benefit", "healthcare",
	 "mass_media", "political_parties", "public_meentings", "unions") var target = "tax_on_poor_class"


export(String, "attracting_immigrants", "demand_of_good", "population_growth", 
	"pluralism_growth") var additional_target = "attracting_immigrants"

export(int) var additional_value = 0
