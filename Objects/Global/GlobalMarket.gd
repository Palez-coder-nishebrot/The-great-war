extends Node


var goods_quantity: Dictionary = {}


func _init():
	var path: String = "res://Resources/Good/"
	var folder: DirAccess = DirAccess.open(path)
	var _err_ = folder.list_dir_begin()
	var file = folder.get_next()
	
	while file != "":
		if file != "good.gd":
			var fle = load(path + file)
			goods_quantity[fle] = 0.0
		file = folder.get_next()


func clear_list():
	for i in goods_quantity:
		goods_quantity[i] = 0.0


func set_exporting_goods():
	clear_list()
	for state in Players.list_of_players:
		var ec_manager = state.economy_manager
		
		for good in ec_manager.local_market:
			var quantity = ec_manager.local_market[good]
			ec_manager.export_goods[good] = quantity
			goods_quantity[good] += quantity
			if quantity < 0 and not is_zero_approx(quantity):
				breakpoint


func fill_lack(ec_manager, good, required_quantity):
	var quantity = goods_quantity[good]
	var q = 0.0
	
	if quantity > required_quantity or is_equal_approx(quantity, required_quantity):
		q = required_quantity
	else:
		q = quantity
	
	ec_manager.local_market[good] += q
	ec_manager.import_goods[good] += q
	goods_quantity[good]          -= q

	return q


func check_goods_quantity(good, quantity):
	var glob_m_q = goods_quantity[good]
	if glob_m_q > quantity or is_equal_approx(glob_m_q, quantity):
		return true
	return false
