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


func meet_the_needs_of_poor_and_middle_classes():
	for population_manager in list_of_population_managers:
		var player = population_manager.player
		
		population_manager.welfare = -4
		
		meet_the_needs(player, population_manager)


func meet_the_needs(player, population_manager):
	for good in population_manager.needs.list_of_needs:
		var quanity_of_good = good.quantity
		var name_of_good = good.name_of_good
		var price_of_good = GlobalMarket.prices_of_goods[name_of_good] * quanity_of_good
		
		#breakpoint
#		if name_of_good == "grain":
#			breakpoint
		
		if quanity_of_good == 0.0:
			population_manager.welfare += 1
		
		elif population_manager.money > price_of_good:
			var local_market = player.local_market
			if quanity_of_good <= local_market[name_of_good]:
				Functions.buy_good_on_local_market(population_manager, name_of_good, quanity_of_good, local_market)
				population_manager.welfare += 1
				
			elif population_manager.money > Functions.check_good_on_global_market(name_of_good, quanity_of_good, player): 
				population_manager.money -= Functions.buy_good_on_global_market(name_of_good, quanity_of_good, player)
				population_manager.welfare += 1
				
			else: 
				break
		else:
			break
	population_manager.money = population_manager.money * interest_on_deposits


func meet_the_needs_of_rich_class():
	for player in Players.list_of_players:
		var rich_class = player.capitalists_manager
		rich_class.welfare = -4
		
		if rich_class.quantity > 0:
			for good in demands_of_rich_class:
				var price = GlobalMarket.prices_of_goods[good]
				var local_market = player.local_market
				if rich_class.money > price:
					var quanity = demands_of_rich_class[good]
					
					if quanity <= local_market[good]:
						Functions.buy_good_on_local_market(rich_class, good, quanity, local_market)
						rich_class.welfare += 1
					
					elif rich_class.money > Functions.check_good_on_global_market(good, quanity, player):
						rich_class.money -= Functions.buy_good_on_global_market(good, quanity, player)
						rich_class.welfare += 1
					else: 
						break
					
				else:
					return


func resourse_extraction(_game):
	for population_manager in list_of_population_managers:
		var player = population_manager.player
		var size = population_manager.quantity_of_workers
		population_manager.income = 0
		
		if size > 0:
			for good in population_manager.province.resources.keys():
				var quanity = (size * 0.5) * player.economic_bonuses.get("based_production_of_" + good) * population_manager.province.get_bonus_of_production()[tipes_of_DP[good]]
				quanity = quanity * player.economic_bonuses.goods_from_technologies[good] * player.economic_bonuses.get(tipes_of_DP[good])
				
				sell_resources(population_manager, good, stepify(quanity, 0.01))


func sell_resources(population_manager, good, size):
	population_manager.player.local_market[good] += size
	Functions.change_GDP(good, size, population_manager.player)
	var income = GlobalMarket.prices_of_goods[good] * size
	
	population_manager.money += income
	population_manager.income += income


func get_quantity_of_unemployed(tile):
	if tile.workplaces < tile.population_manager.list_of_factory_workers.size():
		var quantity_of_unemployed = tile.population_manager.list_of_factory_workers.size() - tile.workplaces
		tile.population_manager.quantity_of_unemployed = quantity_of_unemployed
		tile.player.quantity_of_unemployed += quantity_of_unemployed
	
	elif tile.workplaces == tile.population_manager.list_of_factory_workers.size():
		tile.population_manager.quantity_of_unemployed = 0
	
	elif tile.workplaces > tile.population_manager.list_of_factory_workers.size():
		tile.population_manager.quantity_of_unemployed = 0
		tile.free_workplaces = tile.workplaces - tile.population_manager.list_of_factory_workers.size()
		
	# get_workers_for_additional_jobs()
	var additional_jobs = tile.workplaces - tile.list_of_buildings.size()
	if additional_jobs < 0:
		additional_jobs = 0
	tile.population_manager.workers_for_additional_jobs = additional_jobs
	# get_workers_for_additional_jobs()
