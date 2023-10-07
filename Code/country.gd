extends Node

class_name Country

var _name: String
var _capital: String
var _color: Color
var _pop: int
var _production: Dictionary

# ctor
func _init(country_name, capital, color):
	_name = country_name
	_capital = capital
	_color = color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
