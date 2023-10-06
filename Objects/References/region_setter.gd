extends Node


class_name RegionSetter


func spawn_enterprises(region: Region):
	var starting_factories = region.starting_factories
	var starting_dp        = region.starting_dp
	var client_owner       = region.client_owner
	
	var DP_list            = region.DP_list
	var factories_list     = region.factories_list
	
	for good in starting_dp:
		var dp = DP.new(good, client_owner.economy_manager)
		var _err
		DP_list.append(dp)
		client_owner.economy_manager.DP_list.append(dp)
		region.append_produced_good(good)
		
		_err = dp.connect("append_produced_good", Callable(region, "append_produced_good"))
		_err = dp.connect("delete_produced_good", Callable(region, "delete_produced_good"))
	
	for type_factory in starting_factories:
		var factory = type_factory.generate_factory(region, client_owner.economy_manager)
		var _err
		factories_list.append(factory)
		client_owner.economy_manager.factories_list.append(factory)
		region.append_produced_good(factory.good)
		
		_err = factory.connect("append_produced_good", Callable(region, "append_produced_good"))
		_err = factory.connect("delete_produced_good", Callable(region, "delete_produced_good"))
	
