extends Camera2D

const MAX_zoom:        float          = 3.0
const MIN_zoom:        float          = 0.5
const ZOOM_SPEED:      float          = 0.1

signal scale_updated


func _ready():
	SceneStorage.set_field("camera", self)


func _input(event):
	if not event is InputEventMouseButton:
		return
	
	if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
		if zoom.x >= MIN_zoom:
			zoom -= Vector2(ZOOM_SPEED, ZOOM_SPEED)
	elif event.button_index == MOUSE_BUTTON_WHEEL_UP:
		if zoom.x <= MAX_zoom:
			zoom += Vector2(ZOOM_SPEED, ZOOM_SPEED)
	emit_signal("scale_updated")
