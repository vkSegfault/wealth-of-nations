extends Node

var scene = preload("res://province.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	var instance = scene.instantiate()
	add_child(instance)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
