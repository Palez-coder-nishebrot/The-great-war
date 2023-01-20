extends Reference


static func detect_children(array_of_detect_mask, childrens):
	for ch in childrens:
		for mask in array_of_detect_mask:
			if mask.compare(ch.name):
				array_of_detect_mask.erase(mask)

	if array_of_detect_mask.size() > 0:
		return array_of_detect_mask.front().error

	return ""


static func create_detect_mask(node_name, error):
	var DetectMask = preload("res://gd_scripts/tool_node_detect_mask.gd")
	var dm = DetectMask.new()
	
	dm.error = error
	dm.node_name = node_name
	
	return dm
