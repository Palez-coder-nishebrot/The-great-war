extends Label

var base_font_size: int


func _ready():
	base_font_size = get_font("font").size
	SceneStorage.await_field("camera", funcref(self, "_on_camera_ready"))


func _on_camera_ready(camera):
	var _error = camera.connect("scale_updated", self, "_on_scale_updated", [camera])
	_on_scale_updated(camera)


func _on_scale_updated(camera):
	get_font("font").size = base_font_size * camera.zoom.x
	#breakpoint
	#
	#
	#
	pass


