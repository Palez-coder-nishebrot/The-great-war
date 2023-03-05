extends Node

class_name PopulationWorldManager

const INTEREST_ON_DEPOSITS: float = 1.05 #Проценты по вкладам

var population_units_list = []

func register_population_unit(population_unit):
	population_units_list.append(population_unit)
	pass


func meet_needs():
	for pop_unit in population_units_list:
		var region       = pop_unit.region
		var client       = region.player
		var local_market = client.local_market
		var pop_unit_quantity = pop_unit.quantity
		pop_unit.welfare = 0
		
		for need_good in pop_unit.population_type.needs:
			var needed_good_quantity = need_good.quantity * pop_unit_quantity
			var good                 = need_good.good_type
			var market_good_quantity = local_market[good]
			
			if market_good_quantity >= needed_good_quantity:
				var expenses = Functions.buy_good_on_local_market(pop_unit, good, needed_good_quantity, client)
				pop_unit.welfare += 1
			else:
				break
	
		var percent = (pop_unit.money * INTEREST_ON_DEPOSITS) - pop_unit.money
		client.money_of_state_bank -= percent
		pop_unit.money += percent
