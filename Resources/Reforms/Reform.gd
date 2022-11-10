extends Resource

class_name Reform

export(Array) var effects = []

export(String, "tax_on_poor_class", "tax_on_rich_class", "tariffs", "education",
	"pensions", "min_salary", "max_working_day", "unemployment_benefit",
	"healthcare", "work_safety",
	
	"political_parties", "public_meentings", "unions", "mass_media") var target = "tax_on_poor_class"

export(String) var reform = ""

export(int) var level_of_reform = 1
