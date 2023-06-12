extends Node

class_name DataManager

const day_of_week: Dictionary = {
	1: "Monday",
	2: "Tuesday",
	3: "Wednesday",
	4: "Thursday",
	5: "Friday",
	6: "Saturday",
	7: "Sunday",
}

const month_of_year: Dictionary = {
	1:  "january",
	2:  "february",
	3:  "march",
	4:  "april",
	5:  "may",
	6:  "june",
	7:  "july",
	8:  "august",
	9:  "september",
	10: "october",
	11: "november",
	12: "december",
}

var day:   int = 1
var month: int = 1
var year:  int = 1914


func _init():
	SceneStorage.timer.data_manager_new_day_func = Callable(self, "new_day")


func new_day():
	day += 1
	if day == 31:
		month += 1
		day = 1
	if month == 13:
		year += 1
		month = 1


func get_data():
	return [
		day,
		month,
		year
	]


func get_month_of_year():
	return month_of_year[month]
