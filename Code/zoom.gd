extends Camera2D


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
			self.fov -= 1
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			self.fov += 1


	if event is InputEventMouseMotion:
		pass
