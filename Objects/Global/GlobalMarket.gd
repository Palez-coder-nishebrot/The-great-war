extends Node

var quanity_of_military_goods: Dictionary = {
	"projectiles":             0,
	"ammo":          0,
	"machine_guns":            0,
	"artillery":          0,
	"plane":            0,
	"rifles": 0,
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
	"mech_parts": 30,
	
	"el_appliances": 80,
	"cars":      300,
	"phone":        100,
	"radio":           100,
	
	"furniture":          40,
	"alcohol":        20,
	"clothes":          60,
	"canned_food":        40,
	"gas":         40,
	
#	"tabaco":           10,
#	"tea":             10,
	
	"ammo":          45,
	"artillery":          45,
	"plane":            45,
	"rifles": 45,
	"tanks":               900,
}

var prices_of_goods_from_other_countries: Dictionary = prices_of_goods.duplicate()

const min_and_max_prices_of_goods: Dictionary = {
	"coal":                  {min_ = 5, max_ = 12},
	"iron":                  {min_ = 5, max_ = 12},
	"oil":                   {min_ = 5, max_ = 12},
	"rubber":                {min_ = 5, max_ = 12},
	"cotton":                {min_ = 5, max_ = 12},
	"grain":                 {min_ = 5, max_ = 10},
	"beasts":                {min_ = 5, max_ = 10},
	"saltpeter":             {min_ = 5, max_ = 12},
	"wood":                  {min_ = 5, max_ = 12},
	
	"steel":                  {min_ = 15, max_ = 45},
	"glass":                  {min_ = 15, max_ = 45},
	"textile":                {min_ = 15, max_ = 45},
	"el_parts":               {min_ = 25, max_ = 45},
	"mech_parts":             {min_ = 10, max_ = 45},
	"lumber":                 {min_ = 15, max_ = 45},
	
	"el_appliances":          {min_ = 30, max_ = 50},
	"cars":                   {min_ = 30, max_ = 100},
	"phone":                  {min_ = 30, max_ = 50},
	"radio":                  {min_ = 30, max_ = 50},
	
	"furniture":              {min_ = 20, max_ = 60},
	"alcohol":                {min_ = 20, max_ = 60},
	"clothes":                {min_ = 20, max_ = 60},
	"canned_food":            {min_ = 30, max_ = 60},
	"gas":                    {min_ = 30, max_ = 60},
	
	"projectiles":            {min_ = 30, max_ = 110},
	"ammo":                   {min_ = 30, max_ = 100},
	"machine_guns":           {min_ = 30,max_ = 250},
	"artillery":              {min_ = 30,max_ = 350},
	"plane":                  {min_ = 30,max_ = 300},
	"rifles":                 {min_ = 30, max_ = 110},
	"tanks":                  {min_ = 30, max_ = 950},
}


const based_prices_of_goods = {
	"coal":     5,
	"iron":     5,
	"oil":      10,
	"rubber":   10,
	"cotton":   10,
	"grain":    5,
	"beasts":   5,
	"saltpeter":5,
	"wood":     5,
	
	"steel":    30,
	"glass":    20,
	"textile":  20,
	"el_parts": 30,
	"lumber":   20,
	"mech_parts": 30,
	
	"el_appliances": 50,
	"cars":          100,
	"phone":         50,
	"radio":         50,
	
	"furniture":     40,
	"alcohol":       30,
	"clothes":       30,
	"canned_food":   30,
	"gas":           30,
	
	"ammo":          30,
	"artillery":     80,
	"plane":         130,
	"rifles":        50,
	"tanks":         400,
}


var demand: Dictionary = Players.output.duplicate()
var supply: Dictionary = Players.output.duplicate()

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


func update_prices(day):
	if fmod(day, 5) == 0.0:
		for good in prices_of_goods:
			var s = float(supply[good]) + 1
			var d = float(demand[good]) + 1
			var based_price = based_prices_of_goods[good]
			var price_of_good = prices_of_goods[good]
			
			var q = ((s / d) * 100) - 100
			
			var price = based_price - (based_price * 0.01) * q
			
			if price > price_of_good:
				prices_of_goods[good] += 0.1 #based_price - (based_price * 0.01) * q
			else:
				prices_of_goods[good] -= 0.1
			
	#			if supply[good] > demand[good]:
	#				prices_of_goods[good] -= 0.1
	#			elif supply[good] < demand[good]:
	#				prices_of_goods[good] += 0.1
	#
			if prices_of_goods[good] > min_and_max_prices_of_goods[good].max_:
				prices_of_goods[good] = min_and_max_prices_of_goods[good].max_
			elif prices_of_goods[good] < min_and_max_prices_of_goods[good].min_:
				prices_of_goods[good] = min_and_max_prices_of_goods[good].min_
#
#			prices_of_goods_from_other_countries[good] = int(prices_of_goods[good] * 1.1)
	clear_supply_and_demand()


func export_goods_from_local_markets():
	for player in Players.list_of_players:
		for good in player.local_market:
			if quanity_of_military_goods.has(good):
				quanity_of_military_goods[good] += player.local_market[good]
			player.export_of_goods[good] += player.local_market[good]
			GlobalMarket.supply[good] += player.local_market[good]
			player.local_market[good] = 0

