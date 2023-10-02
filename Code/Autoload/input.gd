extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
@warning_ignore("unused_parameter")
func _process(delta):
	pass

func _input(event):
	if (event is InputEventKey) and (event.keycode == KEY_ESCAPE) and (event.is_pressed()):
			get_tree().quit()
