extends Camera2D

const MIN_ZOOM: float = 0.05
const MAX_ZOOM: float = 5
const DELTA_ZOOM: float = 0.05
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	#zoom in and out
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if self.zoom.x >= MAX_ZOOM or  self.zoom.y >= MAX_ZOOM:
				return
			self.zoom += Vector2(DELTA_ZOOM, DELTA_ZOOM)
			#print("Camera2D zoom is: {z}".format( { "z": self.get_zoom() } ))
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if self.zoom.x <= MIN_ZOOM or  self.zoom.y <= MIN_ZOOM:
				return
			self.zoom -= Vector2(DELTA_ZOOM, DELTA_ZOOM)
			#print("Camera2D zoom is: {z}".format( { "z": self.get_zoom() } ))


	if event is InputEventMouseMotion:
		pass
