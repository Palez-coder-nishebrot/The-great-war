extends Label

var base_font_size: int


func _ready():
#	base_font_size = get_font("font").size
#	SceneStorage.await_field("camera", funcref(self, "_on_camera_ready"))
	pass


func _on_camera_ready(camera):
#	var _error = camera.connect("scale_updated", Callable(self, "_on_scale_updated").bind(camera))
#	_on_scale_updated(camera)
	pass


func _on_scale_updated(camera):
#	get_font("font").size = base_font_size * camera.zoom.x
	#breakpoint
	#
	#
	#
	pass


