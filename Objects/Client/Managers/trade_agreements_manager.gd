extends Node


class_name TradeAgreementsManager


var sort_countries_sellers_list_func: Callable
var client
var trade_agreements: Array = []


func _init(player):
	client = player
	ManagerDay.connect("sign_new_contracts", Callable(self, "check_goods_lack"))
	ManagerDay.connect("execute_contracts", Callable(self, "execute_contracts"))
	sort_countries_sellers_list_func = Callable(player.economy_manager, "sort_countries_sellers_list")


func check_goods_lack():
	var economy_manager = client.economy_manager
	var s_d_goods = economy_manager.demand_supply_goods
	for good in s_d_goods:
		var arr    = s_d_goods[good]
		var supply = arr[1]
		var demand = arr[0]
		
		var needed_q = snappedf(demand - supply, 0.1)
		if demand > supply:
			if not is_zero_approx(needed_q):
				find_country_seller(good, needed_q)


func find_country_seller(good, q):
	var list = sort_countries_sellers_list_func.call(good, client)
	var quantity = snappedf(q, 0.01)

	for i in list:
		var qoods_for_sale = snappedf(i.economy_manager.goods_for_sale[good], 0.01)
		if is_zero_approx(qoods_for_sale):
			return
		elif snappedf(qoods_for_sale, 0.1) >= snappedf(quantity, 0.1):
			var contract = TradeAgreement.new(i, client, good, quantity)
			return
		else:
			var contract = TradeAgreement.new(i, client, good, qoods_for_sale)
			quantity -= qoods_for_sale


func execute_contracts():
#	for contract in trade_agreements:
#		if contract.seller == client:
#			execute_contract(contract)
	pass


func execute_contract(contract):
	var customer = contract.customer
	var seller   = contract.seller
	var good     = contract.good
	var quantity = contract.quantity
	var market_q = seller.economy_manager.goods_for_sale[good]
	
	if market_q >= quantity:
		print("Контракт исполняется")
		contract.move_goods_to_customer()
		check_profit_from_contract(contract)
	else: # Нарушили контракт!
		var new_quantity = market_q
		contract.quantity = new_quantity
		contract.move_goods_to_customer()
		contract.break_contract()
		
			
func check_profit_from_contract(contract):
	if contract.seller == client:
		return
	
	var good      = contract.good
	var prod_good = client.accounting_manager.produced_goods[good]
	var demand = client.economy_manager.demand_supply_goods[good][0]
	
	if prod_good > demand or is_equal_approx(prod_good, demand):
		contract.break_contract()
