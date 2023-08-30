extends Camera2D

const MIN_ZOOM: float = 0.05
const MAX_ZOOM: float = 5
const DELTA_ZOOM: float = 0.05

@export var CAM_MOVEMENT_SPEED = 3
@export var CAM_MOVEMENT_SPEED_FAST = 10
const VIEWPORT_AREA_DEAD_ZONE = 0.75
const VIEWPORT_AREA_FAST_ZONE = 0.95


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#move camera to border
	var half_x = get_viewport().size.x / 2
	var half_y = get_viewport().size.y / 2
	
	var move_x = - (half_x - get_viewport().get_mouse_position().x)
	var move_y = half_y - get_viewport().get_mouse_position().y

	if (abs(move_x) > half_x * VIEWPORT_AREA_FAST_ZONE):
		var move_x_dir = Vector2((move_x / abs(move_x)) * CAM_MOVEMENT_SPEED_FAST, 0)
		self.translate(move_x_dir)
	elif (abs(move_x) > half_x * VIEWPORT_AREA_DEAD_ZONE):
		var move_x_dir = Vector2((move_x / abs(move_x)) * CAM_MOVEMENT_SPEED, 0)
		self.translate(move_x_dir)

	if (abs(move_y) > half_y * VIEWPORT_AREA_FAST_ZONE):
		var move_y_dir = Vector2(0, (move_y / abs(move_y)) * CAM_MOVEMENT_SPEED_FAST)
		self.translate(-move_y_dir)
	elif (abs(move_y) > half_y * VIEWPORT_AREA_DEAD_ZONE):
		var move_y_dir = Vector2(0, (move_y / abs(move_y)) * CAM_MOVEMENT_SPEED)
		self.translate(-move_y_dir)


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
