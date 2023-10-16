extends Camera2D

const MIN_ZOOM: float = 0.05
const MAX_ZOOM: float = 5
const DELTA_ZOOM: float = 0.05

@export var CAM_MOVEMENT_SPEED = 3
@export var CAM_MOVEMENT_SPEED_FAST = 10
const VIEWPORT_AREA_DEAD_ZONE = 0.95
const VIEWPORT_AREA_FAST_ZONE = 0.99
const UI_AREA_DEAD_ZONE = 0.85  #instead of hardcoding we should get UI's height here

var mouse_velocity: Vector2
var LMC_pressed: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	#move camera to border
	var half_x = get_viewport().size.x / 2
	var half_y = get_viewport().size.y / 2
	
	var move_x = -(half_x - get_viewport().get_mouse_position().x)
	var move_y = half_y - get_viewport().get_mouse_position().y

	# ignore movement when hovering over UI elements at the top
	var viewport_y = get_viewport().size.y
	var mouse_location_y = get_viewport().get_mouse_position().y
	if( viewport_y * (1 - VIEWPORT_AREA_FAST_ZONE) < mouse_location_y and mouse_location_y < viewport_y * (1 - UI_AREA_DEAD_ZONE) ):  # ignore top 20% where the UI is located
		return

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
		
	#click and move
	if LMC_pressed:
		self.translate(-mouse_velocity * 0.5)
		mouse_velocity = Vector2.ZERO


func _input(event):
	# DEBUG
	#print("Event type: {i}".format( {"i": event.as_text() } ))
	
	# zoom in and out
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if self.zoom.x >= MAX_ZOOM or self.zoom.y >= MAX_ZOOM:
				return
			self.zoom += Vector2(DELTA_ZOOM, DELTA_ZOOM)
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if self.zoom.x <= MIN_ZOOM or self.zoom.y <= MIN_ZOOM:
				return
			self.zoom -= Vector2(DELTA_ZOOM, DELTA_ZOOM)

	if event is InputEventMouseMotion:
		mouse_velocity = event.relative

	# drag and move
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
			#print("LMC Button is being pressed")
			mouse_velocity = Vector2(0, 0)
			LMC_pressed = true
		if event.button_index == MOUSE_BUTTON_LEFT and event.is_released():
			#print("LMC Buttom released")
			LMC_pressed = false
			mouse_velocity = Vector2(0, 0)
	
