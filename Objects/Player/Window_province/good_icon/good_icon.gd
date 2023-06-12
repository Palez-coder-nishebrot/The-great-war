extends TextureRect

var dp: Object


func mouse_entered():
	if dp != null:
		var panel = Functions.create_details_panel(self)
		panel.show_resource_output_details(dp)
