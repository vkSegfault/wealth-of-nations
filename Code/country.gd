extends Node
class_name Country

var _name: String
var _capital: String
var _color: Color
var _production: Dictionary# = { 'fish': 0, 'cars': 0, 'silver': 0 }
var _pop: int

# ctor
func _init( country_name, capital = "NOT PROVIDED", color = Color() ):
	_name = country_name
	_capital = capital
	_color = color

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _process(_delta):
	pass
