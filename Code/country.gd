extends Node

class_name Country

var country_name: String
var capital: String
var color: Color

# ctor
func _init(name, capital, color):
	country_name = name
	capital = capital
	color = color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
