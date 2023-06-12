extends Node

const tipes_of_DP: Dictionary = {
	"coal":     "production_of_mines",
	"iron":    "production_of_mines",
	"oil":     "production_of_mines",
	"rubber":    "production_of_farms",
	"cotton":    "production_of_farms",
	"grain":     "production_of_farms",
	"beasts":      "production_of_farms",
	"saltpeter":   "production_of_mines",
	"wood": "production_of_farms",
}

const demands_of_rich_class: Dictionary = {
	"grain":     0.3,
	"beasts":    0.3,
	"clothes":   0.2,
	"furniture": 0.3,
	"glass":     1,
	"alcohol":   0.5,
	"gas":       0.5,
	"el_appliances": 0.2,
	"phone":     0.3,
	"radio":    0.2,
	"cars": 0.1,
}

var nums: Array = [100, 200]

const rent: int = 0
const interest_on_deposits: float = 1.05 #Проценты по вкладам
var list_of_population_managers: Array = []


func resourse_extraction(_game):
	for region in _game.get_node("TileMap").get_children():
		if region.get_class() == "TextureButton":
			for dp in region.DP_list:
				var good = dp.good
				var pop_unit = region.population.population_types[0]
				
				pop_unit.income = 0
				
				var production_efficiency: float = dp.get_DP_production_efficiency()
				var good_quanity = production_efficiency * pop_unit.quantity
				sell_resources(region.player, good, snapped(good_quanity, 0.01), pop_unit, dp)


func sell_resources(player, good, quanity, pop_unit, dp):
	player.demand_supply_goods[good][1] += quanity
	player.local_market[good] += quanity
	Functions.change_GDP(good, quanity, player)
	var income = player.prices_goods[good] * quanity

	pop_unit.money += income
	pop_unit.income += income
	
	dp.income                 = income
	dp.selling_goods_quantity = quanity
