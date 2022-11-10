extends Resource

export(Array) var conditions = []


func check(population_manager):
	var cost = 0
	for i in conditions:
		cost += (i.new()).check(population_manager)
	if cost == conditions.size():# and Functions.rng(0, 10) < 6: # ~50% вероятность
		return true
	else:
		return false
