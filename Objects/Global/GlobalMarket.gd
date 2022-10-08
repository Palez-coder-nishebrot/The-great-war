extends Node

var quanity_of_military_goods: Dictionary = {
	"projectiles":             0,
	"ammo":          0,
	"machine_guns":            0,
	"artillery":          0,
	"plane":            0,
	"rifles": 0,
	"armored_cars":         0,
	"tanks":               0,}

var prices_of_goods:  Dictionary = {
	"coal":     20,
	"iron":    20,
	"oil":     30,
	"rubber":    10,
	"cotton":    10,
	"grain":     10,
	"beasts":      10,
	"saltpeter":   20,
	"wood": 10,
	
	"steel":     40,
	"glass":    40,
	"textile":     30,
	"el_parts": 70,
	"lumber":   30,
	
	"el_appliances": 80,
	"cars":      300,
	"telegraphs":       100,
	"phone":        100,
	"radio":           100,
	
	"furniture":          40,
	"alcohol":        20,
	"clothes":          60,
	"canned_food":        40,
	"gas":         40,
	
	"tabaco":           10,
	"tea":             10,
	
	"projectiles":             45,
	"ammo":          45,
	"machine_guns":            45,
	"artillery":          45,
	"plane":            45,
	"rifles": 45,
	"armored_cars":         500,
	"tanks":               900,
}

var prices_of_goods_from_other_countries: Dictionary = prices_of_goods.duplicate()

const min_and_max_prices_of_goods: Dictionary = {
	"coal":                  {min_ = 10, max_ = 20},
	"iron":                 {min_ = 20, max_ = 30},
	"oil":                  {min_ = 20, max_ = 40},
	"rubber":                 {min_ = 10, max_ = 20},
	"cotton":                 {min_ = 10, max_ = 20},
	"grain":                  {min_ = 10, max_ = 20},
	"beasts":                   {min_ = 10, max_ = 20},
	"saltpeter":                {min_ = 20, max_ = 30},
	"wood":              {min_ = 10, max_ = 20},
	
	"steel":                  {min_ = 40, max_ = 60},
	"glass":                 {min_ = 20, max_ = 50},
	"textile":                  {min_ = 20, max_ = 40},
	"el_parts":        {min_ = 60, max_ = 80},
	"lumber":          {min_ = 20, max_ = 40},
	
	"el_appliances":    {min_ = 60, max_ = 100},
	"cars":             {min_ = 40, max_ = 400},
	"telegraphs":              {min_ = 40, max_ = 150},
	"phone":               {min_ = 40, max_ = 150},
	"radio":                  {min_ = 40, max_ = 150},
	
	"furniture":              {min_ = 30, max_ = 60},
	"alcohol":            {min_ = 20, max_ = 40},
	"clothes":              {min_ = 30, max_ = 60},
	"canned_food":            {min_ = 40, max_ = 60},
	"gas":             {min_ = 20, max_ = 60},
	
	"tabaco":               {min_ = 20, max_ = 35},
	"tea":                 {min_ = 20, max_ = 35},
	
	"projectiles":             {min_ = 30, max_ = 110},
	"ammo":          {min_ = 30, max_ = 100},
	"machine_guns":            {min_ = 30,max_ = 250},
	"artillery":          {min_ = 30,max_ = 350},
	"plane":            {min_ = 30,max_ = 300},
	"rifles": {min_ = 30, max_ = 110},
	"armored_cars":         {min_ = 30, max_ = 600},
	"tanks":               {min_ = 30, max_ = 950},
}

var demand: Dictionary = Players.output.duplicate()
var supply: Dictionary = Players.output.duplicate()

const goods: Dictionary = {
	"rubber": {"coal": 1},
	"oil":  {"coal": 1},
	"steel":  {"coal": 0.8, "iron": 1},
	"glass": {"coal": 1},
	"textile":  {"cotton": 0.5},
	
	"el_parts": {
		"steel":     0.8,
		"rubber":    0.5,
		"glass":     0.8,
	},
	"lumber":   {
		"wood": 1,
	},
	"el_appliances": {
		"el_parts": 0.8,
		"steel":    0.8
	},
	"cars":      {
		"rubber":    1,
		"steel":     2,
		"glass":    0.8,
	},
	"telegraphs":       {
		"steel":    0.8,
		"el_parts":     1,
	},
	"phone":        {
		"steel":               0.8,
		"el_parts":     1,
	},
	"radio":           {
		"steel":               0.8,
		"glass":               0.8,
		"el_parts":     1,
	},
	"furniture":          {
		"lumber":       0.8,
	},
	"alcohol":        {"grain":    0.5, "coal": 0.5, "glass": 0.8,},
	"clothes":          {"textile":    0.8,},
	"canned_food":        {
		"steel":    1,
		"grain":    1,
		"beasts":     1,
	},
	"gas":         {
		"oil":    0.5,
	},
	
	"projectiles":         {
		"steel":   2,
		"saltpeter":  2
	},
	"ammo":         {
		"steel":   0.1,
		"saltpeter": 0.1,
		"coal":   0.3,
		"lumber":   0.1,
	},
	"machine_guns":         {
		"steel":   1,
	},
	"artillery":         {
		"steel":   2,
	},
	"plane":         {
		"lumber":   4,
	},
	"rifles":         {
		"steel":   1,
		"lumber":  2,
	},
	"armored_cars": {
		"cars": 1,
		"steel":      2,
		"machine_guns":   2,
		"artillery": 1,
	},
	"tanks": {
		"cars": 1,
		"steel":      6,
		"machine_guns":   3,
		"artillery": 1,
	},
}


const list_of_resourses: Array = [
	"coal",
	"iron",
	"oil",
	"rubber",
	"cotton",
	"grain",
	"beasts",
	"saltpeter",
	"wood",
	"tabaco",
	"tea",
	]


#const bonuses_for_production_of_civilian_goods: Dictionary = {
#	"furniture":        1,
#	"alcohol":      1,
#	"clothes":        2,
#	"canned_food":      1,
#	"gas":       1,
#	"lumber": 1,
#	"ammo":    3,
#	"projectiles":       2,
#}


#const production: Dictionary = {
#	"coal":     0,
#	"iron":    0,
#	"oil":     0,
#	"rubber":    0,
#	"cotton":    0,
#	"grain":     0.5,
#	"beasts":      0,
#	"saltpeter":   0,
#	"wood": 0,
#	"tabaco":     0,
#	"tea":       0,
#
#	"steel":           0,
#	"textile":           0,
#	"glass":          0,
#	"el_parts": 0,
#	"lumber":   0,
#	"cars":      0,
#	"phone":        0,
#	"radio":           0,
#
#	"furniture":          0,
#	"gas":         0,
#	"alcohol":        0,
#	"clothes":          0,
#	"canned_food":        0,
#
#	"projectiles":             1,
#	"ammo":          1,
#	"machine_guns":            1,
#	"artillery":          1,
#	"plane":            1,
#	"rifles": 1,
#	"armored_cars":         1,
#	"tanks":               1,
#}


const list_of_easy_jobs: Array = [
	"textile",
	#"steel",
	"glass",
	"lumber",
	
	"furniture",
	"alcohol",
	"clothes",
]


func find_building_in_list(name_of_building):
	for i in Players.goods_to_factory:
		if Players.goods_to_factory[i] == name_of_building:
			return i


func clear_supply_and_demand():
	for i in supply:
		supply[i] = 0
	for i in demand:
		demand[i] = 0
#		if list_of_resourses.has(i) or bonuses_for_production_of_civilian_goods.has(i):
#			demand[i] = 0
#		else:
#			demand[i] = 5


func clear_export_and_import():
	for player in Players.list_of_players:
		for good in player.export_of_goods:
			player.export_of_goods[good] = 0
			player.import_of_goods[good] = 0
		for good in player.output:
			player.output[good] = 0


func update_prices():
#	if fmod(day, 5) == 0.0:
	for good in prices_of_goods:
		if supply[good] > demand[good]:
			prices_of_goods[good] -= 0.1
		elif supply[good] < demand[good]:
			prices_of_goods[good] += 0.1
		
		if prices_of_goods[good] > min_and_max_prices_of_goods[good].max_:
			prices_of_goods[good] = min_and_max_prices_of_goods[good].max_
		elif prices_of_goods[good] < min_and_max_prices_of_goods[good].min_:
			prices_of_goods[good] = min_and_max_prices_of_goods[good].min_
		
		prices_of_goods_from_other_countries[good] = int(prices_of_goods[good] * 1.1)
	clear_supply_and_demand()
#else:
#	for good in prices_of_goods:
#		if not list_of_resourses.has(good):
#			demand[good] += 2


func export_goods_from_local_markets():
	for player in Players.list_of_players:
		for good in player.local_market:
			if quanity_of_military_goods.has(good):
				quanity_of_military_goods[good] += player.local_market[good]
			player.export_of_goods[good] += player.local_market[good]
			GlobalMarket.supply[good] += player.local_market[good]
			player.local_market[good] = 0

