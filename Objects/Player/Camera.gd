extends Camera2D

const MAX_zoom:        float          = 2.5
const MIN_zoom:        float          = 1.0
const ZOOM_SPEED:      float          = 0.1

signal scale_updated


func _ready():
	SceneStorage.set_field("camera", self)


func _input(event):
	if not event is InputEventMouseButton:
		return
	
	if event.button_index == BUTTON_WHEEL_UP:
		if zoom.x >= MIN_zoom:
			zoom -= Vector2(ZOOM_SPEED, ZOOM_SPEED)
	elif event.button_index == BUTTON_WHEEL_DOWN:
		if zoom.x <= MAX_zoom:
			zoom += Vector2(ZOOM_SPEED, ZOOM_SPEED)
	emit_signal("scale_updated")
